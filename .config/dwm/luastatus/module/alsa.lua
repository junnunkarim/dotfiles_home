package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/?.lua"
local color = require("color")

widget = {
    plugin = 'alsa',
		opts = {
				timeout = 5,
		},
    cb = function(t)
				if t == nil then
						return nil
				end
        if t.mute then
            return color.sep .. color.vol_ic_fg .. color.vol_ic_bg .. '  '
        else
            local percent = (t.vol.cur - t.vol.min) / (t.vol.max - t.vol.min) * 100
            return string.format(color.sep .. color.vol_ic_fg .. color.vol_ic_bg .. '  ' .. color.vol_fg .. color.vol_bg .. ' %3d%% ', math.floor(0.5 + percent))
        end
    end,
}
