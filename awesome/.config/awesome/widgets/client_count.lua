local gears = require("gears")
local wibox = require("wibox")

require("visual.options")
require("visual.themes." .. THEME_COLORSCHEME .. ".colors")

local c_count_table = {}

c_count_table.client_count_widget_core = wibox.widget {
  {     -- layout
    {   -- margin
      { -- textbox
        id = "icon",
        font = "Iosevka Nerd Font Mono 25",
        markup = '<span color="' ..
            battery_colors.fg_icon .. '"><b></b></span>',
        halign = "center",
        valign = "center",
        widget = wibox.widget.textbox
      },
      margins = {
        left = 15,
        right = 10,
      },
      widget = wibox.container.margin
    },
    bg = battery_colors.bg_icon,

    widget = wibox.container.background,
  },
  {   -- margin
    { -- textbox
      id = "core_text",
      font = "Iosevka Nerd Font Mono 18",
      markup = '<span color="' ..
          battery_colors.fg .. '"><b>' .. tostring(0) .. '</b></span>',
      halign = "center",
      valign = "center",
      widget = wibox.widget.textbox
    },
    margins = {
      left = 10,
      right = 15,
    },
    widget = wibox.container.margin
  },
  widget = wibox.layout.fixed.horizontal,
}

c_count_table.client_count_widget = {
  c_count_table.client_count_widget_core,

  shape = function(cr, w, h)
    return gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 20)
  end,
  shape_border_width = 3,
  shape_border_color = battery_colors.border,
  bg = battery_colors.bg,
  widget = wibox.container.background,
}

function c_count_table.update(client_count)
  c_count_table.client_count_widget_core:get_children_by_id("core_text")[1]:set_markup('<span color="' ..
    battery_colors.fg .. '">' .. client_count .. '</span>')
end

return c_count_table
