local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

require("widgets")
require("core.utils")

require("visual.options")
require("visual.themes." .. THEME_COLORSCHEME .. ".colors")

local systray = require("widgets.tray")
local c_count_table = require("widgets.client_count")

-- {{{ Wibar
screen.connect_signal(
  "request::desktop_decoration",
  function(s)
    -- Each screen has its own tag table.
    --[[
    awful.tag(
      { "", "", "", "", "", "󰚢", "󰸳", "", "󰆩" },
      -- 󰾔
      s,
      awful.layout.layouts[1]
    )
    ]]
    --

    --
    awful.tag.add("", {
      index = 1,
      screen = s,
      layout = awful.layout.suit.tile,
      selected = true,
    })
    --󱃖
    awful.tag.add("", {
      index = 2,
      screen = s,
      layout = awful.layout.suit.max,
      --selected = true,
    })
    --
    awful.tag.add("", {
      index = 3,
      screen = s,
      layout = awful.layout.suit.max,
      --selected = true,
    })
    --
    awful.tag.add("", {
      index = 4,
      screen = s,
      layout = awful.layout.suit.max,
      --selected = true,
    })
    --
    awful.tag.add("", {
      index = 5,
      screen = s,
      layout = awful.layout.suit.max,
      --selected = true,
    })
    --
    awful.tag.add("", {
      index = 6,
      screen = s,
      layout = awful.layout.suit.max,
      --selected = true,
    })
    --󰚢
    awful.tag.add("", {
      index = 7,
      screen = s,
      layout = awful.layout.suit.max,
      --selected = true,
    })
    --󰸳
    awful.tag.add("", {
      index = 8,
      screen = s,
      layout = awful.layout.suit.max,
      --selected = true,
    })
    --
    awful.tag.add("", {
      index = 9,
      screen = s,
      layout = awful.layout.suit.max,
      --selected = true,
    })

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    s.layoutbox = get_layout_indicator(s)

    s.taglist = get_taglist(s)

    local client_count_widget = c_count_table.client_count_widget

    -- s.tasklist = get_tasklist(s)

    -- s.systray = get_systray(s)

    -- main bar
    -- Create the wibox
    s.mywibox = awful.wibar {
      widget = {
        { -- Left widgets
          {
            -- mylauncher,
            app_launcher,
            -- s.tasklist,
            s.mypromptbox,
            separator,

            spacing = 10,
            layout = wibox.layout.fixed.horizontal,
          },
          halign = "left",
          layout = wibox.container.place,
        },
        { -- Middle widgets
          {
            client_count_widget,
            s.taglist,
            s.layoutbox,

            spacing = 10,
            layout = wibox.layout.fixed.horizontal,
          },
          halign = "center",
          layout = wibox.container.place,
        },
        { -- Right widgets
          {
            --keyboard_layout,
            battery,
            time,
            date,
            systray.tray,

            spacing = 10,
            layout = wibox.layout.fixed.horizontal,
          },
          halign = "right",
          layout = wibox.container.place,
        },
        expand = "none",
        layout = wibox.layout.align.horizontal,
      },
      --screen = s,
      bg = bar_colors.bg,
      position = "top",
      height = 35,
      border_width = 6,
      border_color = bar_colors.border,
      margins = {
        --top = beautiful.useless_gap + beautiful.border_width,
        left = beautiful.useless_gap + (beautiful.border_width * 2),
        right = beautiful.useless_gap + (beautiful.border_width * 2),
      },
      shape = function(cr, w, h)
        gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, 15) -- t-left, t-right, b-right, b-left
      end,
    }
  end
)
-- }}}
