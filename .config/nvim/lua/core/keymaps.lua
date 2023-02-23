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

vim.g.mapleader = " "

-- Native keymaps
---- Better window management
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
