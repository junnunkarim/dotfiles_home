function change_colorscheme(colorscheme)
	colorscheme = colorscheme or "nord"
	vim.cmd.colorscheme(colorscheme)
	--vim.api.nvim_set_hl(0, "Normal", {bg = "none"} )
	--vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"} )
end

--local available, gruvbox_baby = pcall(require, "gruvbox-baby")
--if available then
--  vim.g.gruvbox_baby_use_original_palette = true
--end

--require("core.highlight_group")

local color = "base16-everforest"

change_colorscheme(color)
