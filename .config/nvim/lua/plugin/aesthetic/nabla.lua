local helper = require("core.helper")

local available, nabla = pcall(require, "nabla")
if not available then
  return
end

--{{ keymaps
--
helper.set_keymap("n", "<leader>eh", "<cmd>lua require('nabla').toggle_virt()<cr>", {noremap = true, silent = true, desc = "Hover LaTeX equations"})
helper.set_keymap("n", "<leader>et", "<cmd>lua require('nabla').popup()<cr>", {noremap = true, silent = true, desc = "Toggle LaTeX equations"})
--
--}}
