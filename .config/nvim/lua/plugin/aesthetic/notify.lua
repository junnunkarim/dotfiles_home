local helper = require("core.helper")

local available, notify = pcall(require, "notify")
if not available then
  return
end

--{{ keymaps
--
--helper.set_keymap("n", "<leader>zz", ":ZenMode<cr>", {noremap = true, silent = true, desc = "Toggle zen-mode"})
--
--}}

local options = {}

notify.setup(options)

vim.notify = notify
