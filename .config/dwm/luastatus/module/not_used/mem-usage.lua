widget = luastatus.require_plugin('mem-usage-linux').widget{
    timer_opts = {period = 2},
    cb = function(t)
        local used_kb = t.total.value - t.avail.value
        return string.format('^c#282828^^b#689d6a^  ^c#689d6a^^b#282828^ %3.2fGiB ', used_kb / 1024 / 1024)
    end,
}
