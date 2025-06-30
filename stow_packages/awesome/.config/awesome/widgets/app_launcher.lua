local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

require("visual.options")
require("visual.themes." .. THEME_COLORSCHEME .. ".colors")


app_launcher = wibox.widget {
  {
    { -- widget
      font = "Iosevka Nerd Font Mono 20",
      markup = '<span color="' .. app_launcher_colors.fg_icon .. '"><b>󰣇</b></span>',
      halign = "center",
      valign = "center",
      widget = wibox.widget.textbox
    },

    buttons = {
      awful.button(
        {}, 1,
        function()
          awful.spawn(os.getenv("HOME") .. "/.config/awesome/scripts/rofi_run")
        end
      ),
    },
    margins = {
      left = 15,
      right = 15,
    },
    widget = wibox.container.margin
  },
  bg = app_launcher_colors.bg,
  shape = function(cr, w, h)
    return gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 10)
  end,
  shape_border_width = 3,
  shape_border_color = app_launcher_colors.border,
  widget = wibox.container.background,
}
