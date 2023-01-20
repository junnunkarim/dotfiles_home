local function keymap(mode, map, command, opts)
  local options = {
    noremap=true,
    silent=true
  }

  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, map, command, options)
end

local opts = {
  noremap = true,
  silent = true,
}

vim.g.mapleader = " "

--vim.keymap.set("n", "<leader>nt", vim.cmd.Ex)

-- Plugin keymaps
keymap("n", "<leader>n", ":NvimTreeToggle<cr>", {noremap = true, silent = true, desc = "Toggle nvim-tree"})
keymap("n", "<leader>h", ":NvimTreeFocus<cr>", {noremap = true, silent = true, desc = "Focus nvim-tree"})
keymap("n", "<leader>u", ":UndotreeToggle<cr>", {noremap = true, silent = true, desc = "Toggle undotree"})

-- Native keymaps
---- Better window management
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
