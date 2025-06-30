require("config.options")
require("config.keymaps")
require("config.autocmds")

-- do not load colorscheme and plugins if config is loaded by vscode
if not vim.g.vscode then
	require("config.lazy")
	require("config.colorscheme")
end
