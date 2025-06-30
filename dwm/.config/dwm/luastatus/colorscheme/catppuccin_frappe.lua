-- couldn't find any other clean way
package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/helper/?.lua"

-- get the specific color table from helper.colorschemes module
local c = require("colorschemes")["catppuccin_frappe"]
local fcolor = require("fcolor")

local color = {
	-- separator
	sep = fcolor("bg", c["crust"]) .. fcolor("fg", c["mantle"]) .. "|",

	-- date
	date_ic_fg = fcolor("fg", c["crust"]),
	date_ic_bg = fcolor("bg", c["red"]),
	date_fg = fcolor("fg", c["red"]),
	date_bg = fcolor("bg", c["crust"]),

	-- time
	time_ic_fg = fcolor("fg", c["crust"]),
	time_ic_bg = fcolor("bg", c["pink"]),
	time_fg = fcolor("fg", c["pink"]),
	time_bg = fcolor("bg", c["crust"]),

	-- wifi
	wifi_ic_fg = fcolor("fg", c["crust"]),
	wifi_ic_bg = fcolor("bg", c["blue"]),
	wifi_fg = fcolor("fg", c["blue"]),
	wifi_bg = fcolor("bg", c["crust"]),

	-- battery
	btt_ic_fg = fcolor("fg", c["crust"]),
	btt_ic_bg = fcolor("bg", c["peach"]),
	btt_fg = fcolor("fg", c["peach"]),
	btt_bg = fcolor("bg", c["crust"]),

	-- volume
	vol_ic_fg = fcolor("fg", c["mauve"]),
	vol_ic_bg = fcolor("bg", c["crust"]),
	vol_fg = fcolor("fg", c["mauve"]),
	vol_bg = fcolor("bg", c["crust"]),

	-- brightness
	brgn_ic_fg = fcolor("fg", c["text"]),
	brgn_ic_bg = fcolor("bg", c["crust"]),
	brgn_fg = fcolor("fg", c["text"]),
	brgn_bg = fcolor("bg", c["crust"]),
}

return color
