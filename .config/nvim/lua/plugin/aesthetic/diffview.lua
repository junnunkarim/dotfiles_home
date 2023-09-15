local helper = require("core.helper")

local available, diffview = pcall(require, "diffview")
if not available then
  return
end

local options = {}

diffview.setup(options)

helper.set_keymap("n", "<leader>gd", ":DiffviewOpen<cr>", {noremap = true, silent = true, desc = "Open git diffview"})
helper.set_keymap("n", "<leader>gc", ":DiffviewClose<cr>", {noremap = true, silent = true, desc = "Close git diffview"})
