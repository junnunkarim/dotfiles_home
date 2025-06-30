local mason = require("plugins.lsp.mason")
local lspconfig = require("plugins.lsp.lspconfig")

return {
  -- the following order is important
  mason,
  lspconfig,
}
