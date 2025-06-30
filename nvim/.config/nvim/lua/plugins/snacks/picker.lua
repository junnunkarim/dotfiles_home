local sources = require("plugins.snacks.pickers")

-- border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },

local default_layout = {
	preset = "custom_dropdown",
}

local layouts = {
	custom_dropdown = {
		layout = {
			backdrop = true,
			row = 1,
			width = 0.9,
			min_width = 80,
			height = 0.9,
			border = "",
			box = "vertical",
			{
				box = "vertical",
				border = { " ", " ", " ", " ", " ", " ", " ", " " },
				title = "{title} {live} {flags}",
				title_pos = "center",
				{ win = "input", height = 1, border = "bottom" },
				{ win = "list", border = "none" },
			},
			{
				win = "preview",
				title = "{preview}",
				height = 0.5,
				border = "rounded",
			},
		},
	},
	custom_sidebar = {
		layout = {
			backdrop = false,
			width = 40,
			min_width = 40,
			height = 0,
			position = "left",
			border = "none",
			box = "vertical",
			{
				win = "input",
				height = 1,
				-- border = "rounded",
				border = { " ", " ", " ", " ", " ", "", " ", " " },
				title = "{title} {live} {flags}",
				title_pos = "center",
			},
			{ win = "list", border = "none" },
			{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
		},
	},
}

local win = {
	-- input window
	input = {
		keys = {
			["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
			["<Tab>"] = { "list_down", mode = { "i", "n" } },

			["<a-p>"] = { "preview_scroll_up", mode = { "i", "n" } },
			["<a-n>"] = { "preview_scroll_down", mode = { "i", "n" } },
			["<c-p>"] = { "preview_scroll_up", mode = { "i", "n" } },
			["<c-n>"] = { "preview_scroll_down", mode = { "i", "n" } },

			["s"] = { "edit_vsplit", mode = { "n" } },
			["S"] = { "edit_split", mode = { "n" } },

			["t"] = { { "tab", "tcd" }, mode = { "n" } },

			["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
		},
	},
	-- result list window
	list = {
		keys = {
			["<S-Tab>"] = { "list_up", mode = { "n", "x" } },
			["<Tab>"] = { "list_down", mode = { "n", "x" } },

			["<a-p>"] = "preview_scroll_up",
			["<a-n>"] = "preview_scroll_down",
			["<c-p>"] = "preview_scroll_up",
			["<c-n>"] = "preview_scroll_down",

			["s"] = "edit_vsplit",
			["S"] = "edit_split",

			["t"] = { { "tab", "tcd" } },

			["-"] = { { "pick_win", "jump" } },
		},
	},
}

return {
	enabled = true,
	prompt = "  ",
	-- ui_select = false,
	layout = default_layout,
	layouts = layouts,
	sources = sources,
	win = win,
}
