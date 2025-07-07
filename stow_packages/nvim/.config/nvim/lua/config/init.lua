require("config.options")
require("config.general")

-- do not load colorscheme and plugins if config is loaded by vscode
if not vim.g.vscode then
  require("config.lazy")
  require("config.lsp")
  require("config.colorscheme")
end
