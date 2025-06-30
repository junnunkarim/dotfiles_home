package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/helper/?.lua"

local c = require("colorschemes")["nord"]
local fcolor = require("fcolor")

local color = {
	-- set colors to modules
	sep = fcolor("bg", c["nord0"]) .. fcolor("fg", c["nord0"]) .. "|", -- separator

	date_ic_fg = fcolor("fg", c["nord0"]),
	date_ic_bg = fcolor("bg", c["nord10"]),
	date_fg = fcolor("fg", c["nord0"]),
	date_bg = fcolor("bg", c["nord9"]),

	time_ic_fg = fcolor("fg", c["nord0"]),
	time_ic_bg = fcolor("bg", c["nord14"]),
	time_fg = fcolor("fg", c["nord14"]),
	time_bg = fcolor("bg", c["nord0"]),

	wifi_ic_fg = fcolor("fg", c["nord0"]),
	wifi_ic_bg = fcolor("bg", c["nord13"]),
	wifi_fg = fcolor("fg", c["nord13"]),
	wifi_bg = fcolor("bg", c["nord0"]),

	btt_ic_fg = fcolor("fg", c["nord0"]), -- battery
	btt_ic_bg = fcolor("bg", c["nord12"]),
	btt_fg = fcolor("fg", c["nord12"]),
	btt_bg = fcolor("bg", c["nord0"]),

	vol_ic_fg = fcolor("fg", c["nord11"]), -- volume
	vol_ic_bg = fcolor("bg", c["nord0"]),
	vol_fg = fcolor("fg", c["nord11"]),
	vol_bg = fcolor("bg", c["nord0"]),

	brgn_ic_fg = fcolor("fg", c["nord15"]), -- brightness
	brgn_ic_bg = fcolor("bg", c["nord0"]),
	brgn_fg = fcolor("fg", c["nord15"]),
	brgn_bg = fcolor("bg", c["nord0"]),
}

return color
