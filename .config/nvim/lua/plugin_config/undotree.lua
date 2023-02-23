local available, undotree = pcall(require, "undotree")
if not available then
  return
end

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

keymap("n", "<leader>u", ":UndotreeToggle<cr>", {noremap = true, silent = true, desc = "Toggle undotree"})
