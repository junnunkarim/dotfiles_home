-- {{{ Library
-- Standard awesome library
local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")

require("visual.options")
require("visual.themes." .. THEME_COLORSCHEME .. ".wallpaper")

-- Bling library
local available, bling = pcall(require, "custom_modules.bling")
-- }}}


local wall_directory = os.getenv("HOME") .. "/.config/wallpaper/"

if available then
  -- A slideshow with pictures from different sources changing every 10 minutes
  bling.module.wallpaper.setup {
    wallpaper = wallpaper_names,
    position = "maximized",
    change_timer = 1200,
  }
else
  -- {{{ Wallpaper
  screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
      screen = s,
      widget = {
        {
          image = wall_directory .. "mist_forest_nord.jpg",
          --upscale   = true,
          --downscale = true,
          widget = wibox.widget.imagebox,
        },
        valign = "center",
        halign = "center",
        tiled = false,
        widget = wibox.container.tile,
      }
    }
  end)
  -- }}}
end
