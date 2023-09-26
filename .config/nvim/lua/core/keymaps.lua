local helper = require("core.helper")

vim.g.mapleader = " "

local opts = {
  noremap = true,
  silent = true,
}

-- Native keymaps
---- Better window management
helper.set_keymap("n", "<C-h>", "<C-w>h", opts)
helper.set_keymap("n", "<C-j>", "<C-w>j", opts)
helper.set_keymap("n", "<C-k>", "<C-w>k", opts)
helper.set_keymap("n", "<C-l>", "<C-w>l", opts)
helper.set_keymap("n", "<C-l>", "<C-w>l", opts)

helper.set_keymap("n", "<a-d>", "<C-d>zz", opts)
helper.set_keymap("i", "<a-d>", "<esc><C-d>zzi", opts)
helper.set_keymap("n", "<a-u>", "<C-u>zz", opts)
helper.set_keymap("i", "<a-u>", "<esc><C-u>zzi", opts)

helper.set_keymap("n", "<leader>nc", "<cmd>noh<cr>", {noremap = true, silent = true, desc = "Remove search highlights"})

helper.set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", {noremap = true, silent = true, desc = "Toggle LSP code-action"})
helper.set_keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", {noremap = true, silent = true, desc = "Rename selected function"})
