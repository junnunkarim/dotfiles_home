local helper = require("core.helper")

local available, neoclip = pcall(require, "neoclip")
if not available then
  return
end

require("telescope").load_extension("neoclip")

--{{ keymaps
--
helper.set_keymap("n", "<leader>cc", ":Telescope neoclip<cr>", {noremap = true, silent = true, desc = "Toggle neoclip"})
--
--}}

local options = {}

neoclip.setup()
