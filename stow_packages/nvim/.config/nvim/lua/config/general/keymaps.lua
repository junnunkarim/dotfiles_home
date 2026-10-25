local function set_keymap(mode, key, action, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end

  vim.keymap.set(mode, key, action, options)
end

-- set `spacebar` as the leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- window management
set_keymap("n", "<C-h>", "<C-w>h")
set_keymap("n", "<C-j>", "<C-w>j")
set_keymap("n", "<C-k>", "<C-w>k")
set_keymap("n", "<C-l>", "<C-w>l")
set_keymap("n", "<C-l>", "<C-w>l")

-- surround word/selection --
-- ----------------------- --
-- with ()
set_keymap(
  "n",
  "<leader>(",
  'ciw(<C-r>")<Esc>',
  { desc = "surround word with ()" }
)
set_keymap(
  "v", --
  "<leader>(",
  'c(<C-r>")<Esc>',
  { desc = "surround selection with ()" }
)
-- with []
set_keymap(
  "n",
  "<leader>[",
  'ciw[<C-r>"]<Esc>',
  { desc = "surround word with []" }
)
set_keymap(
  "v", --
  "<leader>[",
  'c[<C-r>"]<Esc>',
  { desc = "surround selection with []" }
)
-- with {}
set_keymap(
  "n",
  "<leader>{",
  'ciw{<C-r>"}<Esc>',
  { desc = "surround word with {}" }
)
set_keymap(
  "v", --
  "<leader>{",
  'c{<C-r>"}<Esc>',
  { desc = "surround selection with {}" }
)
-- with <>
set_keymap(
  "n",
  "<leader><",
  'ciw<<C-r>"><Esc>',
  { desc = "surround word with <>" }
)
set_keymap(
  "v", --
  "<leader><",
  'c<<C-r>"><Esc>',
  { desc = "surround selection with <>" }
)
-- with ""
set_keymap(
  "n",
  "<leader>\"",
  'ciw\"<C-r>"\"<Esc>',
  { desc = 'surround word with ""' }
)
set_keymap(
  "v", --
  "<leader>\"",
  'c\"<C-r>"\"<Esc>',
  { desc = 'surround selection with ""' }
)
-- with ''
set_keymap(
  "n",
  "<leader>\'",
  'ciw\'<C-r>"\'<Esc>',
  { desc = "surround word with ''" }
)
set_keymap(
  "v", --
  "<leader>\'",
  'c\'<C-r>"\'<Esc>',
  { desc = "surround selection with ''" }
)

-- vertical motion
-- set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
-- set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- navigate in insert and normal modes with alt + u/d
set_keymap("n", "<a-u>", "<C-u>zz")
set_keymap("n", "<a-d>", "<C-d>zz")
set_keymap("i", "<a-u>", "<esc><C-u>zzi")
set_keymap("i", "<a-d>", "<esc><C-d>zzi")

-- edit
set_keymap("i", "<C-BS>", "<C-o>db", { desc = "Delete word with backspace" })

-- registers
set_keymap(
  "x",
  "<leader>p",
  '"_dP',
  { desc = "Paste selection without overwriting yank register" }
)

-- buffers
set_keymap("n", "gp", "<cmd>bprevious<cr>", { desc = "Goto previous buffer" })
set_keymap("n", "gn", "<cmd>bnext<cr>", { desc = "Goto next buffer" })
set_keymap("n", "gl", "<cmd>blast<cr>", { desc = "Goto last buffer" })

-- error/debug
set_keymap(
  "n",
  "<leader>el",
  function() vim.print(vim.lsp.get_clients()[1].server_capabilities) end,
  { desc = "Show capabilities of current attached LSP" }
)
set_keymap(
  "n",
  "<leader>ech",
  "<cmd>checkhealth<cr>",
  { desc = "Run all healthchecks" }
)
set_keymap(
  "n",
  "<leader>ecl",
  "<cmd>checkhealth lsp<cr>",
  { desc = "Run LSP healthcheck" }
)

-- ui
set_keymap(
  "n",
  "<leader>wr",
  "<cmd>source ~/.config/nvim/lua/config/colorscheme.lua<cr>",
  { desc = "Reload colorscheme" }
)

-- misc
set_keymap(
  "n",
  "<leader>mc",
  "<cmd>noh<cr>",
  { desc = "Remove search highlights" }
)

-- terminal
local file_exists = vim.uv.fs_stat(
  vim.fn.expand("~/.config/nvim/plugin/term.lua")
) ~= nil

if file_exists then
  set_keymap(
    "n",
    "<leader>tt",
    "<cmd>SelfTerm float<cr>",
    { desc = "Toggle Terminal (float)" }
  )
  set_keymap(
    { "n", "t" },
    "<a-t>",
    "<cmd>SelfTerm float<cr>",
    { desc = "Toggle Terminal (float)" }
  )
  set_keymap(
    "n",
    "<leader>th",
    "<cmd>SelfTerm horizontal<cr>",
    { desc = "Toggle Terminal (horizontal)" }
  )
  set_keymap(
    { "n", "t" },
    "<a-h>",
    "<cmd>SelfTerm horizontal<cr>",
    { desc = "Toggle Terminal (horizontal)" }
  )
  set_keymap(
    "n",
    "<leader>tv",
    "<cmd>SelfTerm vertical<cr>",
    { desc = "Toggle Terminal (vertical)" }
  )
  set_keymap(
    { "n", "t" },
    "<a-v>",
    "<cmd>SelfTerm vertical<cr>",
    { desc = "Toggle Terminal (vertical)" }
  )
  set_keymap(
    "n",
    "<leader>tc",
    "<cmd>SelfTerm hide_all<cr>",
    { desc = "Hide all terminal" }
  )
  set_keymap(
    { "n", "t" },
    "<a-c>",
    "<cmd>SelfTerm hide_all<cr>",
    { desc = "Hide all terminal" }
  )
  set_keymap(
    "n",
    "<leader>tk",
    "<cmd>SelfTerm kill_all<cr>",
    { desc = "Kill all terminal" }
  )
end
