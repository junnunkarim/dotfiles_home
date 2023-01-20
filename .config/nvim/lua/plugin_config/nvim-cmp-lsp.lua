local available, cmp = pcall(require, "cmp")
if not available then
  return
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local available, capabilities = pcall(require, "cmp_nvim_lsp")
if not available then
  return
end

capabilities.default_capabilities()

-- The following example advertise capabilities to `clangd`.
--require'lspconfig'.clangd.setup {
--  capabilities = capabilities,
--}
