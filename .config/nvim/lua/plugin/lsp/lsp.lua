local available_lsp, lspconfig = pcall(require, "lspconfig")

if not available_lsp then
  return
end


local available_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if available_cmp_lsp then
  capabilities = cmp_lsp.default_capabilities()
else
  capabilities = capabilities
end


local available_clangd, clangd = pcall(require, "clangd_extensions")

if available_clangd then
  lspconfig.clangd.setup {
    on_attach = function()
      require("clangd_extensions.inlay_hints").setup_autocmd()
      require("clangd_extensions.inlay_hints").set_inlay_hints()
    end,
    capabilities = capabilities,
  }
else
  lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.texlab.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.html.setup {
  capabilities = capabilities,
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
}
