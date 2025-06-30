local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

require("core.utils")
require("visual.options")


-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
  {
    "hotkeys",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end
  },
  {
    "manual",
    terminal .. " -e man awesome"
  },
  {
    "edit config",
    editor_cmd .. " " .. awesome.conffile
  },
  {
    "restart",
    awesome.restart
  },
  {
    "quit",
    function()
      awesome.quit()
    end
  },
}

mymainmenu = awful.menu(
  {
    items = {
      { "awesome", myawesomemenu, beautiful.awesome_icon },
      { "open terminal", terminal },
    }
  }
)

mylauncher = awful.widget.launcher(
  {
    image = beautiful.awesome_icon,
    menu = mymainmenu
  }
)

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
