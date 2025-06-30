local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

require("core.utils")

-- Bling library
-- local available_bling, bling = pcall(require, "custom_modules.bling")
-- }}}

require("visual.options")
require("visual.themes." .. THEME_COLORSCHEME .. ".colors")

--[[
if available_bling then
  bling.widget.tag_preview.enable {
    show_client_content = true,  -- Whether or not to show the client content
    x = 50,                       -- The x-coord of the popup
    y = 10,                       -- The y-coord of the popup
    scale = 0.25,                 -- The scale of the previews compared to the screen
    honor_padding = true,        -- Honor padding when creating widget size
    honor_workarea = true,       -- Honor work area when creating widget size
    placement_fn = function(c)    -- Place the widget using awful.placement (this overrides x & y)
      awful.placement.top_left(c, {
        margins = {
          top = 50,
          left = 660
        }
      })
    end,
    background_widget = wibox.widget {    -- Set a background image (like a wallpaper) for the widget
      image = beautiful.wallpaper,
      horizontal_fit_policy = "fit",
      vertical_fit_policy = "fit",
      widget = wibox.widget.imagebox
    }
  }
end
]]
--

get_taglist = function(s)
  -- Create a taglist widget
  taglist_core = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    --filter = function (t)
    --return t.selected or #t:clients() > 0
    --end,
    style = {
      shape = function(cr, w, h)
        gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 30) -- t-left, t-right, b-right, b-left
      end,

      font = "Iosevka Nerd Font Mono 30",
      bg_focus = taglist_colors.bg_focus,
      bg_urgent = taglist_colors.bg_urgent,
      fg_empty = taglist_colors.fg,
      fg_focus = taglist_colors.fg_focus,
      fg_occupied = taglist_colors.fg_occupied,
      fg_urgent = taglist_colors.fg_urgent,
      --shape_border_width = 0,
      shape_border_color_focus = taglist_colors.border,
    },
    buttons = {
      awful.button(
        {}, 1,
        function(t)
          t:view_only()
        end
      ),
      awful.button(
        { SUPER }, 1,
        function(t)
          if client.focus then
            client.focus:move_to_tag(t)
          end
        end
      ),
      awful.button(
        {}, 3,
        awful.tag.viewtoggle
      ),
      awful.button(
        { SUPER }, 3,
        function(t)
          if client.focus then
            client.focus:toggle_tag(t)
          end
        end
      ),
      awful.button(
        {}, 4,
        function(t)
          awful.tag.viewprev(t.screen)
        end
      ),
      awful.button(
        {}, 5,
        function(t)
          awful.tag.viewnext(t.screen)
        end
      ),
    },
    widget_template = {
      {   -- background
        { -- margin
          id = "text_role",
          align = "center",
          valign = "center",
          widget = wibox.widget.textbox,
        },
        margins = {
          left = 10,
          right = 10,
        },
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,

      -- Add support for hover colors and an index label
      create_callback = function(self, c3, text, objects) --luacheck: no unused args
        --self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
        --self:get_children_by_id('text_role')[1].markup = '<b> '..text..' </b>'
        self:connect_signal(
          'mouse::enter',
          function()
            --[[
          if available_bling then
            -- BLING: Only show widget when there are clients in the tag
            if #c3:clients() > 0 then
              -- BLING: Update the widget with the new tag
              awesome.emit_signal("bling::tag_preview::update", c3)
              -- BLING: Show the widget
              awesome.emit_signal("bling::tag_preview::visibility", s, true)
            end
          end
          ]]
            --

            if self.bg ~= taglist_colors.hover then
              self.backup = self.bg
              self.backup_shape_border_color = self.shape_border_color
              self.has_backup = true
            end

            self.bg = taglist_colors.hover
            self.shape_border_color = taglist_colors.hover
          end
        )

        self:connect_signal(
          'mouse::leave',
          function()
            -- BLING: Turn the widget off
            --awesome.emit_signal("bling::tag_preview::visibility", s, false)

            if self.has_backup then
              self.bg = self.backup
              self.shape_border_color = self.backup_shape_border_color
            end
          end
        )
      end,

      --[[
  update_callback = function(self, c3, text, objects) --luacheck: no unused args
    --self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
    self:get_children_by_id('text_role')[1].markup = '<b> '..text..' </b>'
  end,
  ]] --
    },
  }

  taglist = wibox.widget {
    { -- margin
      taglist_core,

      margins = {
        left = 20,
        right = 20,
        top = 4,
        bottom = 4,
      },
      widget = wibox.container.margin
    },
    shape = function(cr, w, h)
      gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 20) -- t-left, t-right, b-right, b-left
    end,
    bg = taglist_colors.bg,
    shape_border_width = 3,
    shape_border_color = taglist_colors.border,
    widget = wibox.container.background,
  }

  return taglist
end
