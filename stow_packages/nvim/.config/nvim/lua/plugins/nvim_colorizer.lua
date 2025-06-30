local options = {
	lazy_load = true,
	user_default_options = {
		css = true, -- Enable all CSS *features*:
		-- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
		css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		-- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
		tailwind = true, -- Enable tailwind colors
		-- parsers can contain values used in `user_default_options`
		sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
		-- Highlighting mode.  'background'|'foreground'|'virtualtext'
		mode = "virtualtext", -- Set the display mode
		-- Virtualtext character to use
		virtualtext = "■",
		-- Virtualtext highlight mode: 'background'|'foreground'
		virtualtext_mode = "foreground",
	},
}

return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = options,
}
