return {
  cmd = { "nimlangserver" },
  filetypes = { "nim" },
  root_markers = { ".nimble", "nim", ".git" },
  settings = {
    nim = {
      inlayHints = {
        typeHints = true,
        exceptionHints = true,
        parameterHints = true,
      },
    },
  },

  -- Enable hints on LSP attach
  on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
}
