local helper = require("core.helper")

local available, notify = pcall(require, "notify")
if not available then
  return
end

--{{ keymaps
--
helper.set_keymap("n", "<leader>dn", "<cmd>lua require('notify').dismiss({ silent = true })<cr>", {noremap = true, silent = true, desc = "Dismiss notifications"})
--
--}}

local options = {}

notify.setup(options)

vim.notify = notify
