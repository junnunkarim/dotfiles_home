-- set `spacebar` as the leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- native keymaps
--- better window management
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<a-d>", "<C-d>zz")
vim.keymap.set("i", "<a-d>", "<esc><C-d>zzi")
vim.keymap.set("n", "<a-u>", "<C-u>zz")
vim.keymap.set("i", "<a-u>", "<esc><C-u>zzi")

-- buffers
vim.keymap.set(
  "n",
  "gp",
  "<cmd>bprevious<cr>",
  { noremap = true, silent = true, desc = "Goto previous buffer" }
)
vim.keymap.set(
  "n",
  "gn",
  "<cmd>bnext<cr>",
  { noremap = true, silent = true, desc = "Goto next buffer" }
)
vim.keymap.set(
  "n",
  "gl",
  "<cmd>blast<cr>",
  { noremap = true, silent = true, desc = "Goto last buffer" }
)

-- ui
vim.keymap.set(
  "n",
  "<leader>wr",
  "<cmd>source ~/.config/nvim/lua/config/colorscheme.lua<cr>",
  { noremap = true, silent = true, desc = "Reload colorscheme" }
)

-- misc
vim.keymap.set(
  "n",
  "<leader>mc",
  "<cmd>noh<cr>",
  { noremap = true, silent = true, desc = "Remove search highlights" }
)

-- terminal
-- if vim.fn.exists(":SelfTerm") ~= 0 then -- won't work because plugin is sourced after keymaps
local file_exists = vim.uv.fs_stat(vim.fn.expand("~/.config/nvim/plugin/term.lua")) ~= nil
if file_exists then
  vim.keymap.set(
    "n",
    "<leader>tt",
    "<cmd>SelfTerm float<cr>",
    { noremap = true, silent = true, desc = "Toggle Terminal (float)" }
  )
  vim.keymap.set(
    { "n", "t" },
    "<a-t>",
    "<cmd>SelfTerm float<cr>",
    { noremap = true, silent = true, desc = "Toggle Terminal (float)" }
  )
  vim.keymap.set(
    "n",
    "<leader>th",
    "<cmd>SelfTerm horizontal<cr>",
    { noremap = true, silent = true, desc = "Toggle Terminal (horizontal)" }
  )
  vim.keymap.set(
    { "n", "t" },
    "<a-h>",
    "<cmd>SelfTerm horizontal<cr>",
    { noremap = true, silent = true, desc = "Toggle Terminal (horizontal)" }
  )
  vim.keymap.set(
    "n",
    "<leader>tv",
    "<cmd>SelfTerm vertical<cr>",
    { noremap = true, silent = true, desc = "Toggle Terminal (vertical)" }
  )
  vim.keymap.set(
    "n",
    "<leader>tc",
    "<cmd>SelfTerm hide_all<cr>",
    { noremap = true, silent = true, desc = "Hide all terminal" }
  )
  vim.keymap.set(
    { "n", "t" },
    "<a-c>",
    "<cmd>SelfTerm hide_all<cr>",
    { noremap = true, silent = true, desc = "Hide all terminal" }
  )
  vim.keymap.set(
    "n",
    "<leader>tk",
    "<cmd>SelfTerm kill_all<cr>",
    { noremap = true, silent = true, desc = "Kill all terminal" }
  )
end
