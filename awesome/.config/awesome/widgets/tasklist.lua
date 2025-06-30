local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

require("core.utils")

-- Bling library
--local available_bling, bling = pcall(require, "custom_modules.bling")
-- }}}

require("visual.options")
require("visual.themes." .. THEME_COLORSCHEME .. ".colors")


--[[
if available_bling then
  bling.widget.task_preview.enable {
    x = 5,                    -- The x-coord of the popup
    y = 20,                    -- The y-coord of the popup
    height = 250,              -- The height of the popup
    width = 250,               -- The width of the popup
    placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
    awful.placement.top(
      c,
      {
        margins = {
          top = 50
        }
      }
    )
    end,
    widget_structure = {
      {
        {
          {
            id = 'icon_role',
            widget = awful.widget.clienticon, -- The client icon
          },
          {
            id = 'name_role', -- The client name / title
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.flex.horizontal
        },
        widget = wibox.container.margin,
        margins = 5
      },
      {
        id = 'image_role', -- The client preview
        resize = true,
        valign = 'center',
        halign = 'center',
        widget = wibox.widget.imagebox,
      },
      layout = wibox.layout.fixed.vertical
    }
  }
end
]]
   --

get_tasklist = function(s)
  -- Create a tasklist widget
  tasklist_core = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    style = {
      shape = function(cr, w, h)
        gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 20) -- t-left, t-right, b-right, b-left
      end,

      font = "Iosevka Nerd Font Mono 13",
      bg_normal = tasklist_colors.bg,
      bg_focus = tasklist_colors.bg_focus,
      bg_minimize = tasklist_colors.bg_minimize,
      fg_normal = tasklist_colors.fg,
      fg_focus = tasklist_colors.fg_focus,
      fg_minimize = tasklist_colors.fg_minimize,
      --shape_border_color_focus = tasklist_colors.dark,
      --shape_border_width_focus = 2,
      --shape_border_color = tasklist_colors.light,
      --shape_border_width = 3,
    },
    buttons = {
      awful.button(
        {}, 1,
        function(c)
          c:activate {
            context = "tasklist",
            action = "toggle_minimization"
          }
        end
      ),
      awful.button(
        {}, 3,
        function()
          awful.menu.client_list {
            theme = {
              width = 250
            }
          }
        end
      ),
      awful.button(
        {}, 4,
        function()
          awful.client.focus.byidx(-1)
        end
      ),
      awful.button(
        {}, 5,
        function()
          awful.client.focus.byidx(1)
        end
      ),
    },
    widget_template = {
      {
        {
          {
            --[[
            id = 'clienticon',
            forced_height = 25,
            forced_width = 25,
            scaling_quality = "fast",
            halign = "center",
            valign = "center",
            widget = awful.widget.clienticon,
            ]] --

            id = "text_role",
            halign = "center",
            valign = "center",
            widget = wibox.widget.textbox,
          },
          strategy = "max",
          width = 200,
          widget = wibox.container.constraint,
        },
        margins = {
          left = 20,
          right = 20,
          bottom = 2,
          top = 2,
        },
        widget  = wibox.container.margin
      },
      id = 'background_role',
      widget = wibox.container.background,
    },
  }

  tasklist = wibox.widget {
    {   -- background
      { -- put it in a specific sector
        {
          widget = tasklist_core,
        },
        margins = {
          left = 5,
          right = 5,
        },
        layout = wibox.container.margin
      },
      shape = function(cr, w, h)
        gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 20) -- t-left, t-right, b-right, b-left
      end,
      bg = tasklist_colors.bg,
      shape_border_width = 3,
      shape_border_color = tasklist_colors.border,
      widget = wibox.container.background,
    },
    strategy = "max",
    width = 600,
    widget = wibox.container.constraint,
  }

  return tasklist
end
