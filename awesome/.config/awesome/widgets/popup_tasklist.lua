local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local dpi = beautiful.xresources.apply_dpi

require("core.utils")

require("visual.options")
require("visual.themes." .. THEME_COLORSCHEME .. ".colors")

local popup_tasklist = {}

popup_tasklist.popup = awful.popup {
  widget    = awful.widget.tasklist {
    screen          = screen[1],
    filter          = awful.widget.tasklist.filter.currenttags,
    style           = {
      shape = function(cr, w, h)
        gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 20) -- t-left, t-right, b-right, b-left
      end,
      bg_normal = tasklist_colors.bg,
      bg_focus = tasklist_colors.bg_focus,
      bg_minimize = tasklist_colors.bg_minimize,
      fg_normal = tasklist_colors.fg,
      fg_focus = tasklist_colors.fg_focus,
      fg_minimize = tasklist_colors.fg_minimize,
    },
    layout          = {
      spacing     = 5,
      -- forced_num_rows = 2,
      homogeneous = true,
      layout      = wibox.layout.grid.horizontal
    },
    widget_template = {
      {
        {
          id     = 'clienticon',
          widget = awful.widget.clienticon,
        },
        margins = 15,
        widget  = wibox.container.margin,
      },
      id              = 'background_role',
      forced_width    = dpi(100),
      forced_height   = dpi(100),
      widget          = wibox.container.background,

      -- called once after the widget instance is created
      create_callback = function(self, c, index, objects) --luacheck: no unused
        self:get_children_by_id('clienticon')[1].client = c
      end,
    },
  },
  ontop     = true,
  -- not visible when just created
  -- only visible when focus is switched
  visible   = false,
  -- placement = awful.placement.bottom,
  placement = function(w)
    awful.placement.bottom(w, { offset = { y = -200 } })
  end,
  shape     = function(cr, w, h)
    gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 30) -- t-left, t-right, b-right, b-left
  end,
}

function popup_tasklist.check_visibility()
  return popup_tasklist.popup.visible
end

function popup_tasklist.toggle_visibility()
  popup_tasklist.popup.visible = not popup_tasklist.popup.visible
end

function popup_tasklist.auto_hide(timeout)
  gears.timer.start_new(timeout, function()
    popup_tasklist.popup.visible = false
    return false -- This stops the timer
  end)
end

return popup_tasklist
