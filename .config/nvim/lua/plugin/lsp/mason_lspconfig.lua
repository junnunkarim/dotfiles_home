local available_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")

if not available_mason_lsp then
  return
end

mason_lspconfig.setup()
