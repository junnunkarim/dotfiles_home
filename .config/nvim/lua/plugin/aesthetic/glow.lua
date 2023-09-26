local helper = require("core.helper")

local available, glow = pcall(require, "glow")
if not available then
  return
end

--{{ keymaps
--
helper.set_keymap("n", "<leader>gg", "<cmd>Glow<cr>", {noremap = true, silent = true, desc = "Toggle Glow markdown viewer"})
--
--}}

local options = {
  style = "dark",
  width = 120,
}

glow.setup(options)
