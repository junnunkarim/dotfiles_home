local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local battery_widget = require("custom_modules.upower")

require("visual.options")
require("visual.themes." .. THEME_COLORSCHEME .. ".colors")


battery_percent = battery_widget {
  screen = screen,
  --device_path = battery_widget.get_BAT0_device_pathline,
  use_display_device = true,
  instant_update = true,
  widget_template = {
    font = "Iosevka Nerd Font Mono, Bold 15",
    widget = wibox.widget.textbox,
  }
}

battery = wibox.widget (
  { -- background
    { -- layout
      { -- background
        { -- margin
          { -- widget
            font = "Iosevka Nerd Font Mono 30",
            markup = '<span color="' .. battery_colors.fg_icon .. '"><b></b></span>',
            halign = "center",
            valign = "center",
            widget = wibox.widget.textbox
          },
          margins = {
            left = 10,
            right = 10,
          },
          widget = wibox.container.margin
        },
        shape = function(cr, w, h)
          return gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 0)
        end,
        bg = battery_colors.bg_icon,
        widget = wibox.container.background,
      },
      { -- margin
        {
          battery_percent,

          fg = battery_colors.fg,
          widget = wibox.container.background,
        },
        margins = {
          left = 10,
          right = 20,
        },
        widget = wibox.container.margin
      },
      layout = wibox.layout.fixed.horizontal,
    },
    shape_border_width = 3,
    shape_border_color = battery_colors.border,
    shape = function(cr, w, h)
      return gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 100)
    end,
    bg = battery_colors.bg,
    widget = wibox.container.background,
  }
)


-- When UPower updates the battery status, the widget is notified
-- and calls a signal you need to connect to:
battery_percent:connect_signal('upower::update', function (widget, device)
    widget.text = string.format('%3d', device.percentage) .. '%'
end)
