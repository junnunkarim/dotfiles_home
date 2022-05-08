widget = luastatus.require_plugin('battery-linux').widget{
    period = 2,
    cb = function(t)
        local symbol = ({
            Charging    = '',
            Discharging = '',
        })[t.status] or ' '
        local rem_seg
        if t.rem_time then
            local h = math.floor(t.rem_time)
            local m = math.floor(60 * (t.rem_time - h))
            rem_seg = string.format('%2dh %02dm', h, m)
        end
        return {
            string.format('^c#1a1710^^b#f88e38^ %s ^c#f88e38^^b#1a1710^%3d%% ', symbol, t.capacity),
            rem_seg,
        }
    end,
}
