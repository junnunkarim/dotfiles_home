function change_colorscheme(colorscheme)
	colorscheme = colorscheme or "gruvbox"
	vim.cmd.colorscheme(colorscheme)
	--vim.api.nvim_set_hl(0, "Normal", {bg = "none"} )
	--vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"} )
end

change_colorscheme("rose-pine")
