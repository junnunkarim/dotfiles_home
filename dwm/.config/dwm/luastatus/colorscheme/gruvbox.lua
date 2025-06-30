package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/helper/?.lua"

local c = require("colorschemes")["gruvbox"]
local fcolor = require("fcolor")

local color = {
	-- set colors to modules
	sep = fcolor("bg", c["black"]) .. fcolor("fg", c["black"]) .. "|", -- separator

	date_ic_fg = fcolor("fg", c["black"]),
	date_ic_bg = fcolor("bg", c["orange2"]),
	date_fg = fcolor("fg", c["black"]),
	date_bg = fcolor("bg", c["orange1"]),

	time_ic_fg = fcolor("fg", c["black"]),
	time_ic_bg = fcolor("bg", c["yellow1"]),
	time_fg = fcolor("fg", c["yellow1"]),
	time_bg = fcolor("bg", c["black"]),

	wifi_ic_fg = fcolor("fg", c["black"]),
	wifi_ic_bg = fcolor("bg", c["green2"]),
	wifi_fg = fcolor("fg", c["green1"]),
	wifi_bg = fcolor("bg", c["black"]),

	btt_ic_fg = fcolor("fg", c["black"]), -- battery
	btt_ic_bg = fcolor("bg", c["aqua2"]),
	btt_fg = fcolor("fg", c["aqua1"]),
	btt_bg = fcolor("bg", c["black"]),

	vol_ic_fg = fcolor("fg", c["purple1"]), -- volume
	vol_ic_bg = fcolor("bg", c["black"]),
	vol_fg = fcolor("fg", c["purple1"]),
	vol_bg = fcolor("bg", c["black"]),

	brgn_ic_fg = fcolor("fg", c["red1"]), -- brightness
	brgn_ic_bg = fcolor("bg", c["black"]),
	brgn_fg = fcolor("fg", c["red1"]),
	brgn_bg = fcolor("bg", c["black"]),
}

return color
