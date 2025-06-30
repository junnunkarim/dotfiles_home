local options = {
	-- classic, modern, helix
	preset = "helix",

	icons = {
		breadcrumb = "", -- symbol used in the command line area that shows your active key combo
		separator = "|", -- symbol used between a key and it's label
		group = " ", -- symbol prepended to a group
		ellipsis = "…",
	},
}

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	-- opts = options,
	config = function()
		local wk = require("which-key")

		wk.add({
			{ "<leader>g", group = "git" },
			{ "<leader>l", group = "lsp" },
			{ "<leader>m", group = "misc" },
			{ "<leader>p", group = "project" },
			{ "<leader>s", group = "system" },
			{ "<leader>t", group = "utilities" },
			{ "<leader>u", group = "ui" },
		})

		wk.setup(options)
	end,
}
