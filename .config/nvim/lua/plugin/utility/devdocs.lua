local helper = require("core.helper")
local available, devdocs = pcall(require, "nvim-devdocs")

if not available then
  return
end

local options = {
  dir_path = vim.fn.stdpath("data") .. "/devdocs", -- installation directory
  telescope = {}, -- passed to the telescope picker
  float_win = { -- passed to nvim_open_win(), see :h api-floatwin
    relative = "editor",
    height = 20,
    width = 110,
    border = "rounded",
  },
  wrap = true, -- text wrap, only applies to floating window
  previewer_cmd = "glow", -- for example: "glow"
  cmd_args = {"-s", "dark", "-w", "80"}, -- example using glow: { "-s", "dark", "-w", "80" }
  cmd_ignore = {}, -- ignore cmd rendering for the listed docs
  picker_cmd = true, -- use cmd previewer in picker preview
  picker_cmd_args = {"-p"}, -- example using glow: { "-s", "dark", "-w", "50" }
  mappings = { -- keymaps for the doc buffer
    open_in_browser = ""
  },
  ensure_installed = {}, -- get automatically installed
  after_open = function(bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Esc>', ':close<CR>', {})
  end, -- callback that runs after the Devdocs window is opened. Devdocs buffer ID will be passed in
}

devdocs.setup(options)

--{{ keymaps
--
helper.set_keymap("n", "<leader>df", "<cmd>DevdocsFetch<cr>", {noremap = true, silent = true, desc = "Fetch DevDocs metadata"})
helper.set_keymap("n", "<leader>di", "<cmd>DevdocsInstall<cr>", {noremap = true, silent = true, desc = "Install documentation"})
helper.set_keymap("n", "<leader>du", "<cmd>DevdocsUpdate<cr>", {noremap = true, silent = true, desc = "Update documentation"})
helper.set_keymap("n", "<leader>do", "<cmd>DevdocsOpen<cr>", {noremap = true, silent = true, desc = "Open documentation in a normal buffer"})
helper.set_keymap("n", "<leader>dt", "<cmd>DevdocsOpenFloat<cr>", {noremap = true, silent = true, desc = "Open documentation in a floating window"})
--
--}}


