package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/?.lua"
local color = require("color")

local charging_status = {
	Charging = "󰂅",
	Discharging = "󱟤",
	Full = "󱈏",
}

widget = luastatus.require_plugin("battery-linux").widget({
	period = 2,
	cb = function(t)
		-- for k, v in pairs(t) do
		-- 	print(k .. " " .. v)
		-- end

		local symbol = charging_status[t.status] or "󱈏"

		local level = string.format(
			color.sep .. color.btt_ic_fg .. color.btt_ic_bg .. " %s " .. color.btt_fg .. color.btt_bg .. " %0.0f%% ",
			symbol,
			t.capacity
		)

		return level
	end,
})
