local gears = require("gears")
local beautiful = require("beautiful")

require("visual.options")

-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("HOME") .. "/.config/awesome/visual/themes/" .. THEME .. "/theme.lua")
--beautiful.gap_single_client = false

-- remove border when there is only one client
-- screen.connect_signal("arrange", function (s)
--     local only_one = #s.tiled_clients == 1
--     for _, c in pairs(s.clients) do
--         if only_one and not c.floating or c.maximized then
--             c.border_width = 0
--         else
--             c.border_width = beautiful.border_width -- your border width
--         end
--     end
-- end)

-- round borders
-- -------------
client.connect_signal(
  "request::manage",
  function(c)
    c.shape = function(cr, w, h)
      gears.shape.partially_rounded_rect(cr, w, h, true, true, true, true, 20) -- t-left, t-right, b-right, b-left
    end
  end
)
