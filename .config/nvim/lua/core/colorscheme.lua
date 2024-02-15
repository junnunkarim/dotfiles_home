function change_colorscheme(colorscheme)
  colorscheme = colorscheme or "nord"
  vim.cmd.colorscheme(colorscheme)
  --vim.api.nvim_set_hl(0, "Normal", {bg = "none"} )
  --vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"} )
end

--require("core.highlight_group")

local color = "base16-rose-pine"

change_colorscheme(color)
