local available_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")

if not available_mason_lsp then
  return
end

local options = {
  ensure_installed = {
    "bash-language-server",
    "clangd",
    "css-lsp",
    "html-lsp",
    "ltex-ls",
    "lua-language-server",
    "marksman",
    "pyright",
    "rust-analyzer",
    "texlab",
  },
}

mason_lspconfig.setup()
