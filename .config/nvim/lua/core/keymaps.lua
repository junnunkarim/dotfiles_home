local helper = require("core.helper")

vim.g.mapleader = " "

-- Native keymaps
---- Better window management
helper.set_keymap("n", "<C-h>", "<C-w>h", opts)
helper.set_keymap("n", "<C-j>", "<C-w>j", opts)
helper.set_keymap("n", "<C-k>", "<C-w>k", opts)
helper.set_keymap("n", "<C-l>", "<C-w>l", opts)
helper.set_keymap("n", "<C-k>", "<C-w>k", opts)

helper.set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", {noremap = true, silent = true, desc = "Toggle LSP code-action"})
helper.set_keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", {noremap = true, silent = true, desc = "Rename selected function"})
