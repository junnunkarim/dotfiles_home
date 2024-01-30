local helper = require("core.helper")
local available, toggleterm = pcall(require, "toggleterm")
if not available then
  return
end

local options = {
	size = 20,
	open_mapping = [[<a-t>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "single",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
}

toggleterm.setup(options)

--{{ keymaps
--
helper.set_keymap("n", "<leader>cv", "<cmd>ToggleTerm direction=vertical size=80<cr>", {noremap = true, silent = true, desc = "Toggle vertical terminal"})
helper.set_keymap("n", "<leader>ch", "<cmd>ToggleTerm direction=horizontal size=10<cr>", {noremap = true, silent = true, desc = "Toggle horizontal terminal"})
helper.set_keymap("n", "<leader>ct", "<cmd>ToggleTerm direction=tab<cr>", {noremap = true, silent = true, desc = "Toggle horizontal terminal"})
helper.set_keymap("n", "<leader>cf", "<cmd>ToggleTerm direction=float<cr>", {noremap = true, silent = true, desc = "Toggle horizontal terminal"})
helper.set_keymap("n", "<leader>tl", "<cmd>TermSelect<cr>", {noremap = true, silent = true, desc = "List all open terminals"})
--
--}}
