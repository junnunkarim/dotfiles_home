local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

require("core.utils")

require("visual.options")
require("visual.themes." .. THEME_COLORSCHEME .. ".colors")

local systray = {}

local tray_core = wibox.widget {
  screen = screen[1],
  base_size = 28,
  widget = wibox.widget.systray,
}

systray.tray = wibox.widget {
  {
    tray_core,

    margins = {
      left = 5,
      top = 4,
      bottom = 4,
      right = 5,
    },
    widget = wibox.container.margin
  },
  visible = false,
  bg = tray_colors.fg,
  shape = function(cr, w, h)
    gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 15) -- t-left, t-right, b-right, b-left
  end,
  -- shape_border_width = 1,
  -- shape_border_color = tasklist_colors.border,
  widget = wibox.container.background,
}

function systray.toggle_visibility()
  systray.tray.visible = not systray.tray.visible
end

return systray
