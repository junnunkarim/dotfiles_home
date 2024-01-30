local available_lsp, lspconfig = pcall(require, "lspconfig")
if not available_lsp then
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local available_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if available_cmp_lsp then
  capabilities = cmp_lsp.default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
end

--{{ helper functions
--
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  client.server_capabilities.document_formatting = true
end

local lsp_flags = {
  --allow_incremental_sync = true,
  --debounce_text_changes = 150,
}

local function strsplit(s, delimiter)
  local result = {}
  for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

local function get_quarto_resource_path()
  local f = assert(io.popen('quarto --paths', 'r'))
  local s = assert(f:read('*a'))
  f:close()
  return strsplit(s, '\n')[2]
end
--
--}}

local lua_library_files = vim.api.nvim_get_runtime_file("", true)
local lua_plugin_paths = {}
local resource_path = get_quarto_resource_path()
local lsp_util = require("lspconfig.util")
--vim.notify_once(resource_path)


--{{ LSP configuation
--
local available_clangd, clangd = pcall(require, "clangd_extensions")
if available_clangd then
  lspconfig.clangd.setup {
    on_attach = function()
      require("clangd_extensions.inlay_hints").setup_autocmd()
      require("clangd_extensions.inlay_hints").set_inlay_hints()
    end,
    capabilities = capabilities,
    flags = lsp_flags,
  }
else
  lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  }
end

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = false,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
  root_dir = function(fname)
    return lsp_util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or
        lsp_util.path.dirname(fname)
  end
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      },
      runtime = {
        version = 'LuaJIT',
        plugin = lua_plugin_paths,
      },
      diagnostics = {
        globals = { 'vim', 'quarto', 'pandoc', 'io', 'string', 'print', 'require', 'table', 'awesome', 'screen', 'client' },
        disable = { 'trailing-space' },
      },
      workspace = {
        library = lua_library_files,
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false,
      }
    }
  }
}

lspconfig.texlab.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
}

lspconfig.html.setup {
  capabilities = capabilities,
  flags = lsp_flags,
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  }
}

lspconfig.marksman.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
}

lspconfig.marksman.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'markdown', 'quarto' },
  root_dir = lsp_util.root_pattern(".git", ".marksman.toml", "_quarto.yml"),
}

lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.ltex.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "markdown", "tex", "quarto" },
}
--
--}}

if resource_path == nil then
  vim.notify_once("quarto not found, lua library files not loaded")
else
  table.insert(lua_library_files, resource_path .. '/lua-types')
  table.insert(lua_plugin_paths, resource_path .. '/lua-plugin/plugin.lua')
end
