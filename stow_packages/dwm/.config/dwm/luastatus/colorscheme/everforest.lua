package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/helper/?.lua"

local c = require("colorschemes")["everforest"]
local fcolor = require("fcolor")

local color = {
	-- separator
	sep = fcolor("bg", c["black"]) .. fcolor("fg", c["black"]) .. "|", -- separator

	-- date
	date_ic_fg = fcolor("fg", c["black"]),
	date_ic_bg = fcolor("bg", c["yellow2"]),
	date_fg = fcolor("fg", c["black"]),
	date_bg = fcolor("bg", c["yellow1"]),

	-- time
	time_ic_fg = fcolor("fg", c["black"]),
	time_ic_bg = fcolor("bg", c["aqua1"]),
	time_fg = fcolor("fg", c["aqua2"]),
	time_bg = fcolor("bg", c["black"]),

	-- wifi
	wifi_ic_fg = fcolor("fg", c["black"]),
	wifi_ic_bg = fcolor("bg", c["blue1"]),
	wifi_fg = fcolor("fg", c["blue1"]),
	wifi_bg = fcolor("bg", c["black"]),

	-- battery
	btt_ic_fg = fcolor("fg", c["black"]),
	btt_ic_bg = fcolor("bg", c["red1"]),
	btt_fg = fcolor("fg", c["red2"]),
	btt_bg = fcolor("bg", c["black"]),

	-- volume
	vol_ic_fg = fcolor("fg", c["orange1"]),
	vol_ic_bg = fcolor("bg", c["black"]),
	vol_fg = fcolor("fg", c["orange1"]),
	vol_bg = fcolor("bg", c["black"]),

	-- brightness
	brgn_ic_fg = fcolor("fg", c["orange2"]),
	brgn_ic_bg = fcolor("bg", c["black"]),
	brgn_fg = fcolor("fg", c["orange2"]),
	brgn_bg = fcolor("bg", c["black"]),
}

return color
