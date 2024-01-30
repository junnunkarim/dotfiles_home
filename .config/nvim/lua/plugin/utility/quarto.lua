local helper = require("core.helper")

local available, quarto = pcall(require, "quarto")

if not available then
  return
end

local options = {
  debug = false,
  closePreviewOnExit = true,
  lspFeatures = {
    enabled = true,
    languages = { 'r', 'python', 'julia', 'bash' },
    chunks = 'curly', -- 'curly' or 'all'
    diagnostics = {
      enabled = true,
      triggers = { "BufWritePost" }
    },
    completion = {
      enabled = true,
    },
  },
  cmpSource = {
    enabled = true,
  },
   keymap = {
     hover = '<leader>qh',
     definition = '<leader>qd',
     rename = '<leader>qr',
     references = '<leader>qr',
   }
}

quarto.setup(options)

--{{ keymaps
--
helper.set_keymap("n", "<leader>qp", "<cmd>QuartoPreview<cr>", {noremap = true, silent = true, desc = "Open quarto preview"})
--
--}}
