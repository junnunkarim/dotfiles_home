package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/helper/?.lua"

local c = require("colorschemes")["everblush"]
local fcolor = require("fcolor")

local color = {
	-- set colors to modules
	sep = fcolor("bg", c["black"]) .. fcolor("fg", c["black"]) .. "|", -- separator

	date_ic_fg = fcolor("fg", c["black"]),
	date_ic_bg = fcolor("bg", c["green"]),
	date_fg = fcolor("fg", c["black"]),
	date_bg = fcolor("bg", c["green"]),

	time_ic_fg = fcolor("fg", c["black"]),
	time_ic_bg = fcolor("bg", c["red"]),
	time_fg = fcolor("fg", c["red"]),
	time_bg = fcolor("bg", c["black"]),

	wifi_ic_fg = fcolor("fg", c["black"]),
	wifi_ic_bg = fcolor("bg", c["yellow"]),
	wifi_fg = fcolor("fg", c["yellow"]),
	wifi_bg = fcolor("bg", c["black"]),

	btt_ic_fg = fcolor("fg", c["black"]), -- battery
	btt_ic_bg = fcolor("bg", c["blue"]),
	btt_fg = fcolor("fg", c["blue"]),
	btt_bg = fcolor("bg", c["black"]),

	vol_ic_fg = fcolor("fg", c["magenta"]), -- volume
	vol_ic_bg = fcolor("bg", c["black"]),
	vol_fg = fcolor("fg", c["magenta"]),
	vol_bg = fcolor("bg", c["black"]),

	brgn_ic_fg = fcolor("fg", c["cyan"]), -- brightness
	brgn_ic_bg = fcolor("bg", c["black"]),
	brgn_fg = fcolor("fg", c["cyan"]),
	brgn_bg = fcolor("bg", c["black"]),
}

return color
