package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/?.lua"

local color = require("color")

local prefix = color.sep .. color.vol_ic_fg .. color.vol_ic_bg

widget = {
	plugin = "alsa",
	opts = {
		timeout = 5,
	},
	cb = function(t)
		if t == nil then
			return nil
		end

		if t.mute then
			return prefix .. "  "
		else
			local percent = (t.vol.cur - t.vol.min) / (t.vol.max - t.vol.min) * 100

			percent = string.format(prefix .. "  " .. color.vol_fg .. color.vol_bg .. " %0.0f%% ", percent)

			return percent
		end
	end,
}
