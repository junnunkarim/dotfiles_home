vim.opt.list = true
--vim.opt.listchars:append "eol:↴"

local available, indent = pcall(require, "ibl")
if not available then
  return
end

local options = {
  --space_char_blankline = " ",
  --show_current_context = true,
  --show_current_context_start = true,
}

indent.setup(options)
