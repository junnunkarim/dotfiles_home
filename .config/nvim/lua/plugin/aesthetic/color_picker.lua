local helper = require("core.helper")

--{{ keymaps
--
helper.set_keymap("n", "<leader>cc", "<cmd>PickColor<cr>", {noremap = true, silent = true, desc = "Open color picker"})
helper.set_keymap("i", "<A-c>", "<cmd>PickColorInsert<cr>", {noremap = true, silent = true, desc = "Open color picker"})
--
--}}



-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)

require("color-picker").setup({ -- for changing icons & mappings
	-- ["icons"] = { "󰝤", "" },
	-- ["icons"] = { "󰚌", "󰋦" },
	-- ["icons"] = { "", "󰜗" },
	-- ["icons"] = { "", "" },
	-- ["icons"] = { "", "" },
	["icons"] = { "󰝤", "󰃉" },
	["border"] = "rounded", -- none | single | double | rounded | solid | shadow
	["keymap"] = { -- mapping example:
		["U"] = "<Plug>ColorPickerSlider5Decrease",
		["O"] = "<Plug>ColorPickerSlider5Increase",
	},
	["background_highlight_group"] = "Normal", -- default
	["border_highlight_group"] = "FloatBorder", -- default
  ["text_highlight_group"] = "Normal", --default
})

vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
