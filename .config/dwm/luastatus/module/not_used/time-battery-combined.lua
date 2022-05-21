function get_bat_seg(t)
    if not t then
        return '[--×--]'
    end
    if t.status == 'Unknown' or t.status == 'Full' or t.status == 'Not charging' then
        return nil
    end
    local sym = '?'
    if t.status == 'Discharging' then
        sym = '↓'
    elseif t.status == 'Charging' then
        sym = '↑'
    end
    return string.format('[%3d%%%s]', t.capacity, sym)
end

widget = luastatus.require_plugin('battery-linux').widget{
    period = 2,
    cb = function(t)
        return {
            os.date('[%H:%M]'),
            get_bat_seg(t),
        }
    end,
}
