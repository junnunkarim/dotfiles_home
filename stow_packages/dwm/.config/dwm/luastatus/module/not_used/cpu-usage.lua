widget = luastatus.require_plugin('cpu-usage-linux').widget{
    cb = function(usage)
        if usage ~= nil then
            return string.format('^c#282828^^b#fb4934^  ^c#fb4934^^b#282828^%5.1f%% ', usage * 100)
        end
    end,
}
