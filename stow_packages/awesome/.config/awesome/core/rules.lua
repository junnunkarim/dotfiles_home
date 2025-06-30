-- Standard awesome library
local awful = require("awful")
local gears = require("gears")
require("awful.autofocus")
-- Declarative object management
local ruled = require("ruled")

local popup_tasklist = require("widgets.popup_tasklist")
local c_count_table = require("widgets.client_count")
local systray = require("widgets.tray")


-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal(
  "request::rules",
  function()
    -- All clients will match this rule.
    ruled.client.append_rule {
      id = "global",
      rule = {},
      properties = {
        focus = awful.client.focus.filter,
        raise = true,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen
      },
      callback = awful.client.setslave -- Start windows as slave
    }

    -- Floating clients.
    ruled.client.append_rule {
      id = "floating",
      rule_any = {
        instance = {
          "copyq",
          "pinentry"
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Kruler",
          "Sxiv",
          "Tor Browser",
          "Wpa_gui",
          "veromix",
          "xtightvncviewer",
          "Gpick",
          "Alacritty",
          --"wezterm",
          --"kitty",
          "Lxappearance",
          "Xfce-polkit",
          "Protonvpn",
        },
        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester", -- xev.
        },
        role = {
          "AlarmWindow",   -- Thunderbird's calendar.
          "ConfigManager", -- Thunderbird's about:config.
          "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
        }
      },
      properties = {
        floating = true,
        placement = awful.placement.centered
      },
    }

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule
    {
      id = "titlebars",
      rule_any = {
        type = {
          "normal",
          "dialog"
        }
      },
      properties = {
        titlebars_enabled = true,
      },
    }

    -- app rules | tag rules
    ruled.client.append_rule
    {
      rule_any = {
        class = {
          --"org.wezfurlong.wezterm",
          --"Alacritty",
          "kitty",
          "konsole",
          "st-256color",
        }
      },
      properties = {
        tag = function(c) return c.screen.tags[1] end,
        switch_to_tags = true,
        maximized = false,
        placement = awful.placement.centered,
      }
    }

    ruled.client.append_rule
    {
      rule_any = {
        class = {
          "code-oss",
          "Emacs",
          "Geany",
          "jetbrains-idea-ce",
          "jetbrains-pycharm",
          "jetbrains-dataspell",
        }
      },
      properties = {
        tag = function(c) return c.screen.tags[2] end,
        switch_to_tags = true,
        maximized = false,
        placement = awful.placement.centered,
      }
    }

    ruled.client.append_rule
    {
      rule_any = {
        class = {
          "Pcmanfm",
          "Thunar",
          "qBittorrent",
        }
      },
      properties = {
        tag = function(c) return c.screen.tags[3] end,
        switch_to_tags = true,
        maximized = false,
        placement = awful.placement.centered,
      }
    }

    ruled.client.append_rule
    {
      rule_any = {
        class = {
          "firefox",
          "Chromium",
          "Vieb",
          "Nyxt",
        }
      },
      properties = {
        tag = function(c) return c.screen.tags[4] end,
        switch_to_tags = true,
        maximized = false,
        placement = awful.placement.centered,
      }
    }

    ruled.client.append_rule
    {
      rule_any = {
        class = {
          "Gimp",
          "obs",
          "vlc",
          "mpv",
        }
      },
      properties = {
        tag = function(c) return c.screen.tags[5] end,
        switch_to_tags = true,
        maximized = false,
        placement = awful.placement.centered,
      }
    }

    ruled.client.append_rule
    {
      rule_any = {
        class = {
          "calibre",
          "Zathura",
          "sioyek",
          "DesktopEditors",
        }
      },
      properties = {
        tag = function(c) return c.screen.tags[6] end,
        switch_to_tags = true,
        maximized = false,
        placement = awful.placement.centered,
      }
    }

    ruled.client.append_rule
    {
      rule_any = {
        class = {
          "KotatogramDesktop",
          "TelegramDesktop",
        }
      },
      properties = {
        tag = function(c) return c.screen.tags[7] end,
        switch_to_tags = true,
        maximized = false,
        placement = awful.placement.centered,
      }
    }

    ruled.client.append_rule
    {
      rule_any = {
        class = {
          "Ryujinx",
          "yuzu",
          "retroarch",
          "steamwebhelper",
          "steam",
        }
      },
      properties = {
        tag = function(c) return c.screen.tags[8] end,
        switch_to_tags = true,
        maximized = false,
        placement = awful.placement.centered,
      }
    }

    ruled.client.append_rule
    {
      rule_any = {
        class = {
          "GParted",
          "Xfce4-power-manager-settings",
          "Lxappearance",
          "Virt-manager",
        }
      },
      properties = {
        tag = function(c) return c.screen.tags[9] end,
        switch_to_tags = true,
        maximized = false,
        placement = awful.placement.centered,
      }
    }
  end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
  "mouse::enter",
  function(c)
    c:activate {
      context = "mouse_enter",
      raise = false,
    }
  end
)

-- enable popup tasklist widget with auto-hide
client.connect_signal(
  "focus",
  function()
    if not popup_tasklist.check_visibility() then
      popup_tasklist.toggle_visibility() -- show popup on focus change
      popup_tasklist.auto_hide(2)        -- hides the popup after 2 seconds
    end
  end
)

client.connect_signal(
  "focus",
  -- "property::selected",
  function()
    local current_tag = awful.screen.focused().selected_tag
    local c_count = #current_tag:clients()

    -- c_count_table.client_count = c_count
    c_count_table.update(c_count)
  end
)


-- gears.timer {
--   timeout   = 1, -- Time between checks
--   call_now  = true,
--   autostart = true,
--   callback  = function()
--     if awesome.systray() == 0 then -- if systray has no elements
--       systray.toggle_visibility()
--     end
--   end
-- }
-- }}}
