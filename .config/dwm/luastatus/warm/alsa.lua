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
            return '^c#282828^^b#458588^  '
        else
            local percent = (t.vol.cur - t.vol.min) / (t.vol.max - t.vol.min) * 100
            return string.format('^c#282828^^b#458588^  ^c#458588^^b#282828^%3d%% ', math.floor(0.5 + percent))
        end
    end,
}
