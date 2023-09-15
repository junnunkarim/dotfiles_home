local helper = require("core.helper")

local available, lspsaga = pcall(require, "lspsaga")

if not available then
  return
end

--{{ keymaps
--
helper.set_keymap("n", "<leader>ld", ":Lspsaga peek_definition<cr>", {noremap = true, silent = true, desc = "Show LSP code definition"})
helper.set_keymap("n", "<leader>lc", ":Lspsaga incoming_calls ++normal<cr>", {noremap = true, silent = true, desc = "Show incoming calls"})
--
--}}

local options = {
  ui = {
    --code_action_prompt = { enable = false },
    --virtual_text = false,
  },
  definition = {
    keys = {
      --edit = 'o',
      split = "h",
      vsplit = "v",
    }
  },
}

lspsaga.setup(options)
