-- Note that this widget only shows backlight level when it changes.
package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/?.lua"
local color = require("color")

widget = luastatus.require_plugin('backlight-linux').widget{
    cb = function(level)
        if level ~= nil then
            return string.format(color.sep .. color.brgn_ic_fg .. color.brgn_ic_bg .. ' 󰃠 ' .. color.brgn_fg .. color.brgn_bg .. ' %3.0f%% ', level * 100)
        end
    end,
}
