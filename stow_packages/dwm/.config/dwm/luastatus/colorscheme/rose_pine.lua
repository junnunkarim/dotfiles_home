package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/helper/?.lua"

local c = require("colorschemes")["rose_pine"]
local fcolor = require("fcolor")

local color = {
	-- separator
	sep = fcolor("bg", c["base"]) .. fcolor("fg", c["base"]) .. "|",

	-- date
	date_ic_fg = fcolor("fg", c["base"]),
	date_ic_bg = fcolor("bg", c["rose1"]),
	date_fg = fcolor("fg", c["base"]),
	date_bg = fcolor("bg", c["rose"]),

	-- time
	time_ic_fg = fcolor("fg", c["base"]),
	time_ic_bg = fcolor("bg", c["foam"]),
	time_fg = fcolor("fg", c["foam"]),
	time_bg = fcolor("bg", c["base"]),

	-- wifi
	wifi_ic_fg = fcolor("fg", c["base"]),
	wifi_ic_bg = fcolor("bg", c["iris"]),
	wifi_fg = fcolor("fg", c["iris"]),
	wifi_bg = fcolor("bg", c["base"]),

	-- battery
	btt_ic_fg = fcolor("fg", c["base"]),
	btt_ic_bg = fcolor("bg", c["love"]),
	btt_fg = fcolor("fg", c["love"]),
	btt_bg = fcolor("bg", c["base"]),

	-- volume
	vol_ic_fg = fcolor("fg", c["gold"]),
	vol_ic_bg = fcolor("bg", c["base"]),
	vol_fg = fcolor("fg", c["gold1"]),
	vol_bg = fcolor("bg", c["base"]),

	-- brightness
	brgn_ic_fg = fcolor("fg", c["foam"]),
	brgn_ic_bg = fcolor("bg", c["base"]),
	brgn_fg = fcolor("fg", c["foam"]),
	brgn_bg = fcolor("bg", c["base"]),
}

return color
