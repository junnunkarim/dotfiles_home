local helper = require("core.helper")

vim.g.mapleader = " "

-- Native keymaps
---- Better window management
helper.set_keymap("n", "<C-h>", "<C-w>h", opts)
helper.set_keymap("n", "<C-j>", "<C-w>j", opts)
helper.set_keymap("n", "<C-k>", "<C-w>k", opts)
helper.set_keymap("n", "<C-l>", "<C-w>l", opts)
helper.set_keymap("n", "<C-k>", "<C-w>k", opts)
--helper.set_keymap("n", "<C-<lt>>", "<C-w><lt>", opts)
--helper.set_keymap("n", "<C-<gt>>", "<C-w><gt>", opts)
