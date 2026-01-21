-- from "https://github.com/neovim/nvim-lspconfig/blob/master/lsp/clangd.lua"
local function switch_source_header(bufnr, client)
  local method_name = "textDocument/switchSourceHeader"

  if not client or not client:supports_method(method_name) then
    return vim.notify(
      ("method %s is not supported by any servers active on the current buffer"):format(
        method_name
      )
    )
  end

  local params = vim.lsp.util.make_text_document_params(bufnr)

  client:request(method_name, params, function(err, result)
    if err then error(tostring(err)) end

    if not result then
      vim.notify("corresponding file cannot be determined")
      return
    end

    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

local function symbol_info(bufnr, client)
  local method_name = "textDocument/symbolInfo"

  if not client or not client:supports_method(method_name) then
    return vim.notify("Clangd client not found", vim.log.levels.ERROR)
  end

  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_position_params(win, client.offset_encoding)

  client:request(method_name, params, function(err, res)
    if err or #res == 0 then
      -- Clangd always returns an error, there is no reason to parse it
      return
    end

    local container = string.format("container: %s", res[1].containerName)
    local name = string.format("name: %s", res[1].name)

    vim.lsp.util.open_floating_preview({ name, container }, "", {
      height = 2,
      width = math.max(string.len(name), string.len(container)),
      focusable = false,
      focus = false,
      title = "Symbol Info",
    })
  end, bufnr)
end

return {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git",
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  },
  on_init = function(client, init_result)
    if init_result.offsetEncoding then
      client.offset_encoding = init_result.offsetEncoding
    end
  end,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LspClangdSwitchSourceHeader",
      function() switch_source_header(bufnr, client) end,
      { desc = "Switch between source/header" }
    )

    vim.api.nvim_buf_create_user_command(
      bufnr,
      "LspClangdShowSymbolInfo",
      function() symbol_info(bufnr, client) end,
      { desc = "Show symbol info" }
    )
  end,
}
