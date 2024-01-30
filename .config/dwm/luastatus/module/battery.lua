package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/dwm/luastatus/colorscheme/?.lua"
local color = require("color")

widget = luastatus.require_plugin('battery-linux').widget {
  period = 2,
  cb = function(t)
    local symbol = ({
      Charging    = '󰂅',
      Discharging = '󱟤',
    })[t.status] or ''
    local rem_seg

    if t.rem_time then
      local h = math.floor(t.rem_time)
      local m = math.floor(60 * (t.rem_time - h))
      -- rem_seg = string.format('%2dh', h, m)
    end
    return {
      string.format(
        color.sep .. color.btt_ic_fg .. color.btt_ic_bg .. ' %s ' .. color.btt_fg .. color.btt_bg .. ' %3d%% ',
        symbol,
        t.capacity),
      rem_seg,
    }
  end,
}
