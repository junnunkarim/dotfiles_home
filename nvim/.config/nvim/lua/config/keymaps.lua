local util = require("util")

-- set `spacebar` as the leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- native keymaps
--- better window management
util.set_keymap("n", "<C-h>", "<C-w>h")
util.set_keymap("n", "<C-j>", "<C-w>j")
util.set_keymap("n", "<C-k>", "<C-w>k")
util.set_keymap("n", "<C-l>", "<C-w>l")
util.set_keymap("n", "<C-l>", "<C-w>l")

util.set_keymap("n", "<a-d>", "<C-d>zz")
util.set_keymap("i", "<a-d>", "<esc><C-d>zzi")
util.set_keymap("n", "<a-u>", "<C-u>zz")
util.set_keymap("i", "<a-u>", "<esc><C-u>zzi")

-- lsp
util.set_keymap(
  "n",
  "<leader>lc",
  "<cmd>lua vim.lsp.buf.code_action()<cr>",
  { desc = "Toggle LSP code-action" }
)

util.set_keymap(
  "n",
  "<leader>lh",
  "<cmd>lua vim.lsp.buf.hover() <cr>",
  { desc = "Toggle LSP hover" }
)

util.set_keymap(
  "n",
  "<leader>lr",
  "<cmd>lua vim.lsp.buf.rename()<cr>",
  { desc = "Rename selected function" }
)

-- ui
util.set_keymap(
  "n",
  "<leader>ur",
  "<cmd>source ~/.config/nvim/lua/config/colorscheme.lua<cr>",
  { desc = "Reload colorscheme" }
)

-- misc
util.set_keymap("n", "<leader>mc", "<cmd>noh<cr>", { desc = "Remove search highlights" })
