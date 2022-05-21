widget = {
    plugin = 'pulse',
    cb = function(t)
        if t.mute then
            return '[mute]'
        end
        local percent = (t.cur / t.norm) * 100
        return string.format('[%3d%%]', math.floor(0.5 + percent))
    end,
}
