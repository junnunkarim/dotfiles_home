local helper = require("core.helper")

local available, zen = pcall(require, "zen-mode")
if not available then
  return
end

--{{ keymaps
--
helper.set_keymap("n", "<leader>zz", ":ZenMode<cr>", {noremap = true, silent = true, desc = "Toggle zen-mode"})
--
--}}

local options = {}

zen.setup(options)
