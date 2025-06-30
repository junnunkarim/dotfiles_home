package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/helper/?.lua"

local c = require("matugen_colors")
local fcolor = require("fcolor")

local color = {
	-- separator
	sep = fcolor("bg", c["on_primary_fixed"]) .. fcolor("fg", c["on_primary_fixed"]) .. "|", -- separator

	-- date
	date_ic_fg = fcolor("fg", c["primary"]),
	date_ic_bg = fcolor("bg", c["on_primary"]),
	date_fg = fcolor("fg", c["on_primary"]),
	date_bg = fcolor("bg", c["primary"]),

	-- time
	time_ic_fg = fcolor("fg", c["tertiary"]),
	time_ic_bg = fcolor("bg", c["on_tertiary"]),
	time_fg = fcolor("fg", c["on_tertiary"]),
	time_bg = fcolor("bg", c["tertiary"]),

	-- wifi
	wifi_ic_fg = fcolor("fg", c["secondary"]),
	wifi_ic_bg = fcolor("bg", c["on_secondary"]),
	wifi_fg = fcolor("fg", c["on_secondary"]),
	wifi_bg = fcolor("bg", c["secondary"]),

	-- battery
	btt_ic_fg = fcolor("fg", c["on_primary"]),
	btt_ic_bg = fcolor("bg", c["primary"]),
	btt_fg = fcolor("fg", c["primary_fixed"]),
	btt_bg = fcolor("bg", c["on_primary_fixed"]),

	-- volume
	vol_ic_fg = fcolor("fg", c["on_tertiary"]),
	vol_ic_bg = fcolor("bg", c["tertiary"]),
	vol_fg = fcolor("fg", c["primary_fixed"]),
	vol_bg = fcolor("bg", c["on_primary_fixed"]),

	-- brightness
	brgn_ic_fg = fcolor("fg", c["error"]),
	brgn_ic_bg = fcolor("bg", c["on_error"]),
	brgn_fg = fcolor("fg", c["on_error"]),
	brgn_bg = fcolor("bg", c["error"]),
}

return color
