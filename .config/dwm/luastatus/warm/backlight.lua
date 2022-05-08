-- Note that this widget only shows backlight level when it changes.
widget = luastatus.require_plugin('backlight-linux').widget{
    cb = function(level)
        if level ~= nil then
            return string.format('^c#282828^^b#cc241d^  ^c#fb4934^^b#282828^%3.0f%% ', level * 100)
        end
    end,
}
