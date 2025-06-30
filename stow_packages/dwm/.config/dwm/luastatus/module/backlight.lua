-- Note that this widget only shows backlight level when it changes.
package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/?.lua"
local color = require("color")

widget = luastatus.require_plugin("backlight-linux").widget({
	cb = function(level)
		if level == nil then
			return nil
		end

		level = string.format(
			color.sep
				.. color.brgn_ic_fg
				.. color.brgn_ic_bg
				.. " 󰃠 "
				.. color.brgn_fg
				.. color.brgn_bg
				.. " %0.0f%% ",
			level * 100
		)

		return level
	end,
})
