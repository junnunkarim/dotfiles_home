local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

require("visual.options")
require("visual.themes." .. THEME_COLORSCHEME .. ".colors")


-- {{{ Titlebars
-- Add a titlebar if titlebars_enabled is set to true in the rules.

client.connect_signal("request::titlebars", function(c)
  if c.requests_no_titlebar then
    return
  end

  awful
      .titlebar(c, {
        position = "top",
        size = dpi(25),
        font = beautiful.font_name .. " 16"
      })
      :setup({
        {
          { --- Left
            top = dpi(2),
            bottom = dpi(2),
            left = dpi(8),
            widget = wibox.container.margin,
          },
          {   --- Middle
            { --- Title
              align = "center",
              buttons = {
                --- Move client
                awful.button({
                  modifiers = {},
                  button = 1,
                  on_press = function()
                    c.maximized = false
                    c:activate({ context = "mouse_click", action = "mouse_move" })
                  end,
                }),
                --- Resize client
                awful.button({
                  modifiers = {},
                  button = 3,
                  on_press = function()
                    c.maximized = false
                    c:activate({ context = "mouse_click", action = "mouse_resize" })
                  end,
                }),
              },
              widget = awful.titlebar.widget.titlewidget(c),
            },
            layout = wibox.layout.flex.horizontal,
          },
          --- Right
          -- {},
          layout = wibox.layout.align.horizontal,
        },
        -- fg = taglist_colors.fg,
        -- bg = taglist_colors.bg,
        fg = other_colors.font,
        bg = other_colors.bg,
        shape = function(cr, w, h)
          gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, 15) -- t-left, t-right, b-right, b-left
        end,
        widget = wibox.container.background,
      })

  --[[
  awful
      .titlebar(c, {
        position = "bottom",
        size = dpi(15),
      })
      :setup({
        bg = other_colors.bg,
        shape = function(cr, w, h)
          gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, 15) -- t-left, t-right, b-right, b-left
        end,
        widget = wibox.container.background,
      })
  ]]
  --
end)

-- }}}
