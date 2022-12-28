local function keymap(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opts = {
  noremap = true,
  silent = true,
}

vim.g.mapleader = " "

--vim.keymap.set("n", "<leader>nt", vim.cmd.Ex)

keymap("n", "<leader>n", ":NvimTreeToggle<cr>", opts)

-- Better window management
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
