-- couldn't find any other clean way
package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/helper/?.lua"

-- get the specific color table from helper.colorschemes module
local c = require("colorschemes")["dracula"]
local fcolor = require("fcolor")

local color = {
	-- separator
	sep = fcolor("bg", c["black0"]) .. fcolor("fg", c["black0"]) .. "|",

	-- date
	date_ic_fg = fcolor("fg", c["black0"]),
	date_ic_bg = fcolor("bg", c["purple"]),
	date_fg = fcolor("fg", c["black0"]),
	date_bg = fcolor("bg", c["purple"]),

	-- time
	time_ic_fg = fcolor("fg", c["black0"]),
	time_ic_bg = fcolor("bg", c["red"]),
	time_fg = fcolor("fg", c["red"]),
	time_bg = fcolor("bg", c["black0"]),

	-- wifi
	wifi_ic_fg = fcolor("fg", c["black0"]),
	wifi_ic_bg = fcolor("bg", c["orange"]),
	wifi_fg = fcolor("fg", c["orange"]),
	wifi_bg = fcolor("bg", c["black0"]),

	-- battery
	btt_ic_fg = fcolor("fg", c["black0"]),
	btt_ic_bg = fcolor("bg", c["cyan"]),
	btt_fg = fcolor("fg", c["cyan"]),
	btt_bg = fcolor("bg", c["black0"]),

	-- volume
	vol_ic_fg = fcolor("fg", c["yellow"]),
	vol_ic_bg = fcolor("bg", c["black0"]),
	vol_fg = fcolor("fg", c["yellow"]),
	vol_bg = fcolor("bg", c["black0"]),

	-- brightness
	brgn_ic_fg = fcolor("fg", c["pink"]),
	brgn_ic_bg = fcolor("bg", c["black0"]),
	brgn_fg = fcolor("fg", c["pink"]),
	brgn_bg = fcolor("bg", c["black0"]),
}

return color
