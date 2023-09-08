local available, diffview = pcall(require, "diffview")
if not available then
  return
end

local options = {}

diffview.setup(options)

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

keymap("n", "<leader>gd", ":DiffviewOpen<cr>", {noremap = true, silent = true, desc = "Toggle git diffview"})
keymap("n", "<leader>gc", ":DiffviewClose<cr>", {noremap = true, silent = true, desc = "Toggle git diffview"})
