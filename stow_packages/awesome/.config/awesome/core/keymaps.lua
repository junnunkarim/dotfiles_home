local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

require("core.utils")
require("core.scratchpads")

local systray = require("widgets.tray")

-- {{{ Key bindings

-- ---------------------------------------------------------- --
-- #------------------ Global Keybindings ------------------# --
-- ---------------------------------------------------------- --
local global_keybindings = {
  awful.key({
    modifiers = { SUPER, "Shift" },
    key = "n",
    on_press = function()
      local tag = awful.screen.focused().selected_tag
      local client_count = #tag:clients()

      naughty.notify({
        title        = "test",
        text         = "client count: " .. client_count,
        font         = "Iosevka Nerd Font Mono 20",
        bg           = "#282828",
        fg           = "#ebdbb2",
        border_width = 0,
        -- border_color = "#98971a",
        shape        = function(cr, w, h)
          return gears.shape.rounded_rect(cr, w, h, 20)
        end,
        margin       = 30,
        ontop        = true,
      })
    end,
    description = "Swap with clients clockwise",
    group = "client",
  }),
  awful.key({
    modifiers = { SUPER, "Shift" },
    key = "j",
    on_press = function()
      awful.client.swap.byidx(1)
    end,
    description = "Swap with clients clockwise",
    group = "client",
  }),
  awful.key({
    modifiers = { SUPER, "Shift" },
    key = "k",
    on_press = function()
      awful.client.swap.byidx(-1)
    end,
    description = "Swap with clients anti-clockwise",
    group = "client",
  }),
  awful.key({
    modifiers = { SUPER },
    key = "u",
    on_press = awful.client.urgent.jumpto,
    description = "Move to urgent client",
    group = "client",
  }),
  awful.key({
    modifiers = { SUPER },
    key = "Right",
    on_press = function()
      awful.tag.incmwfact(0.05)
    end,
    description = "Increase master width factor",
    group = "client",
  }),
  awful.key({
    modifiers = { SUPER },
    key = "Left",
    on_press = function()
      awful.tag.incmwfact(-0.05)
    end,
    description = "Decrease master width factor",
    group = "client",
  }),

  -- Layout related keybindings
  awful.key({
    modifiers = { SUPER, "Control", "Shift" },
    key = "space",
    on_press = function()
      awful.layout.inc(1)
    end,
    description = "Cycle through layouts",
    group = "layout",
  }),
  awful.key({
    modifiers = { SUPER },
    keygroup = "numrow",
    description = "View a specific tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  }),
  awful.key({
    modifiers = { SUPER, "Control" },
    keygroup = "numrow",
    description = "Select multiple tags",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  }),
  awful.key({
    modifiers = { SUPER, "Shift" },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  }),
  awful.key({
    modifiers = { SUPER, "Control", "Shift" },
    keygroup = "numrow",
    description = "Pin focused client on specific tags",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  }),

  -- System (super / super + shift)
  awful.key({
    modifiers = { SUPER },
    key = "Return",
    on_press = function()
      awful.spawn(terminal)
    end,
    description = "Open a terminal",
    group = "applications",
  }),
  awful.key({
    modifiers = { SUPER, "Shift" },
    key = "Return",
    on_press = function()
      if scratch_term ~= nil then
        scratch_term:toggle()
      else
        awful.spawn(os.getenv("HOME") .. "/.bin/scratchpad")
      end
    end,
    description = "Toggle drop-down terminal",
    group = "applications",
  }),
  awful.key({
    modifiers = { SUPER, "Shift" },
    key = "h",
    on_press = function()
      if scratch_btop ~= nil then
        scratch_btop:toggle()
      end
    end,
    description = "Launch Btop",
    group = "applications",
  }),
  awful.key({
    modifiers = { SUPER, "Shift" },
    key = "BackSpace",
    on_press = function()
      if scratch_pass ~= nil then
        scratch_pass:toggle()
      end
    end,
    description = "Launch KeePassXC",
    group = "applications",
  }),
  awful.key({
    modifiers = { SUPER, "Shift" },
    key = "d",
    on_press = function()
      if scratch_zeal ~= nil then
        scratch_zeal:toggle()
      end
    end,
    description = "Launch Zeal Documentation Browser",
    group = "applications",
  }),

  awful.key({
    modifiers = { SUPER },
    key = "b",
    on_press = function()
      for s in screen do
        s.mywibox.visible = not s.mywibox.visible
      end
    end,
    description = "Toggle bar",
    group = "awesome",
  }),

  awful.key({
    modifiers = { SUPER, "Shift" },
    key = "t",
    on_press = function()
      systray.toggle_visibility()
    end,
    description = "Toggle systray visiblity",
    group = "awesome",
  }),
  --awful.key({ SUPER },            "r",     function () awful.screen.focused().mypromptbox:run() end,
  --          {description = "run prompt", group = "Launcher"}),
  --awful.key({ SUPER }, "d", function() menubar.show() end,
  --          {description = "show the menubar", group = "Launcher"}),

  awful.key({ SUPER }, "d", function()
    awful.spawn(os.getenv("HOME") .. "/.config/awesome/scripts/rofi_run")
  end, { description = "Open application menu", group = "Launcher" }),

  awful.key({ SUPER }, "e", function()
    awful.spawn(os.getenv("HOME") .. "/.config/awesome/scripts/rofi_emoji")
  end, { description = "Open emoji picker menu", group = "Launcher" }),

  awful.key({ SUPER, "Shift" }, "b", function()
    awful.spawn(os.getenv("HOME") .. "/.config/awesome/scripts/rofi_buku")
  end, { description = "Open application menu", group = "Launcher" }),

  awful.key({ SUPER }, "t", function()
    awful.spawn(os.getenv("HOME") .. "/.config/awesome/scripts/theme_switcher")
  end, { description = "Open theme switcher", group = "Launcher" }),

  awful.key({ SUPER }, "n", function()
    awful.spawn("networkmanager_dmenu --config ~/.config/awesome/external_configs/networkmanager-dmenu/config.ini")
  end, { description = "Open network menu", group = "Launcher" }),

  awful.key({ SUPER }, "x", function()
    awful.spawn(os.getenv("HOME") .. "/.config/awesome/scripts/powermenu")
  end, { description = "Open power menu", group = "Launcher" }),

  awful.key({ SUPER }, "h", function()
    awful.spawn(os.getenv("HOME") .. "/.config/awesome/scripts/clipboard")
  end, { description = "Open clipboard manager", group = "Launcher" }),

  awful.key({ SUPER }, "r", function()
    awful.spawn(os.getenv("HOME") .. "/.config/awesome/scripts/rofi_calc")
  end, { description = "Open calculator ", group = "Launcher" }),

  awful.key({ SUPER }, "l", function()
    awful.spawn("slock")
  end, { description = "Lock screen", group = "Launcher" }),

  awful.key({ SUPER, "Shift" }, "r", awesome.restart, { description = "Reload awesomewm", group = "awesome" }),

  awful.key({ SUPER }, "w", function()
    mymainmenu:toggle()
  end, { description = "Show main-menu", group = "awesome" }),

  awful.key({ SUPER, "Shift" }, "q", awesome.quit, { description = "Quit awesomewm", group = "awesome" }),

  awful.key({ SUPER }, "s", hotkeys_popup.show_help, { description = "Show keybindings", group = "awesome" }),

  awful.key({ SUPER, "Shift" }, "l", function()
    awful.prompt.run({
      prompt = "Run Lua code: ",
      textbox = awful.screen.focused().mypromptbox.widget,
      exe_callback = awful.util.eval,
      history_path = awful.util.get_cache_dir() .. "/history_eval",
    })
  end, { description = "Lua execute prompt", group = "awesome" }),

  -- Tags related keybindings
  awful.key({ SUPER }, "grave", function()
    local focused = awful.screen.focused() -- gets current focused screen
    --naughty.notification {text=tostring(#focused.tags)}
    for i = 1, #focused.tags do            -- gets tag count
      awful.tag.viewidx(-1, focused)
      if #focused.clients > 0 then         -- if client count is greater than 0
        return
      end
    end
  end, { description = "Cycle through non-empty tags anti-clockwise", group = "tag" }),
  awful.key({ SUPER }, "Tab", function()
    local focused = awful.screen.focused()
    --naughty.notification {text=tostring(focused.tags)}
    for i = 1, #focused.tags do    -- gets tag count
      awful.tag.viewidx(1, focused)
      if #focused.clients > 0 then -- if client count is greater than 0
        return
      end
    end
  end, { description = "Cycle through non-empty tags clockwise", group = "tag" }),
  awful.key({ SUPER }, "Escape", awful.tag.history.restore, { description = "Go back", group = "tag" }),

  -- Focus related keybindings
  awful.key({ ALT }, "Tab", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),
  awful.key({ ALT }, "grave", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "client" }),
  awful.key({ ALT, "Shift" }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, { description = "go back", group = "client" }),
  --awful.key({ SUPER, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
  --          {description = "focus the next screen", group = "screen"}),
  --awful.key({ SUPER, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
  --          {description = "focus the previous screen", group = "screen"}),
  awful.key({ SUPER, "Shift" }, "i", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:activate({ raise = true, context = "key.unminimize" })
    end
  end, { description = "restore minimized", group = "client" }),

  -- Other programs or scripts (super + ctrl)
  awful.key({ SUPER, "Control" }, "r", function()
    awful.spawn("redshift -P -O 5500")
  end, { description = "Activate bluelight filter (Day)", group = "applications" }),
  awful.key({ SUPER, "Control" }, "v", function()
    awful.spawn("redshift -P -O 3500")
  end, { description = "Activate bluelight filter (Night)", group = "applications" }),
  awful.key({ SUPER, "Control" }, "n", function()
    awful.spawn("redshift -x")
  end, { description = "Deactivate bluelight filter", group = "applications" }),

  awful.key({ SUPER, "Control" }, "p", function()
    awful.spawn("picom -b")
  end, { description = "Turn on compositor (picom)", group = "applications" }),
  awful.key({ SUPER, "Control" }, "u", function()
    awful.spawn("pkill picom")
  end, { description = "Turn off compositor (picom)", group = "applications" }),

  awful.key({ SUPER, "Control" }, "g", function()
    awful.spawn("gpick")
  end, { description = "Open color picker", group = "applications" }),

  -- Applications (super + alt)
  awful.key({ SUPER, ALT }, "b", function()
    awful.spawn("chromium")
  end, { description = "Launch Chromium", group = "applications" }),
  awful.key({ SUPER, ALT }, "e", function()
    awful.spawn("firefox")
  end, { description = "Launch Firefox", group = "applications" }),

  awful.key({ SUPER, ALT }, "f", function()
    awful.spawn("thunar")
  end, { description = "Launch Thunar", group = "applications" }),

  awful.key({ SUPER, ALT }, "v", function()
    --awful.spawn("alacritty -e nvim")
    --awful.spawn("kitty nvim")
    awful.spawn("neovide")
  end, { description = "Launch Neovide(nvim)", group = "applications" }),
  awful.key({ SUPER, ALT }, "n", function()
    --awful.spawn("alacritty -e bash ~/.bin/nnn_run -T v")
    awful.spawn("kitty ~/.bin/nnn_run -T v")
  end, { description = "Launch nnn", group = "applications" }),

  -- System Keys
  awful.key({}, "Print", function()
    awful.spawn("flameshot full -p " .. os.getenv("HOME") .. "/Pictures/SS/")
  end, { description = "Take Full-screen screenshot", group = "System" }),
  awful.key({ SUPER }, "Print", function()
    awful.spawn("flameshot gui")
  end, { description = "Open screenshot gui", group = "System" }),
  awful.key({ ALT }, "Print", function()
    awful.spawn("flameshot full -d 5000 -p " .. os.getenv("HOME") .. "/Pictures/SS/")
  end, { description = "Take full-screen screenshot after 5 seconds", group = "System" }),
  awful.key({ "Shift" }, "Print", function()
    awful.spawn("flameshot full -d 10000 -p " .. os.getenv("HOME") .. "/Pictures/SS/")
  end, { description = "Take full-screen screenshot after 10 seconds", group = "System" }),

  awful.key({}, "XF86MonBrightnessUp", function()
    awful.spawn('brightnessctl -d "intel_backlight" set +2%')
  end, { description = "Increase screen brightness", group = "System" }),
  awful.key({}, "XF86MonBrightnessDown", function()
    awful.spawn('brightnessctl -d "intel_backlight" set 2%-')
  end, { description = "Decrease screen brightness", group = "System" }),
  awful.key({ SUPER }, "F1", function()
    awful.spawn('brightnessctl -d "intel_backlight" set 2%-')
  end, { description = "Decrease screen brightness", group = "System" }),
  awful.key({ SUPER }, "F2", function()
    awful.spawn('brightnessctl -d "intel_backlight" set +2%')
  end, { description = "Increase screen brightness", group = "System" }),

  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.spawn("pactl set-sink-volume 0 +5%")
  end, { description = "Increase volume", group = "System" }),
  awful.key({}, "XF86AudioLowerVolume", function()
    awful.spawn("pactl set-sink-volume 0 -5%")
  end, { description = "Decrease volume", group = "System" }),
  awful.key({}, "XF86AudioMute", function()
    awful.spawn("pactl set-sink-mute 0 toggle")
  end, { description = "Mute volume", group = "System" }),
  awful.key({ SUPER }, "F5", function()
    awful.spawn("pactl set-sink-volume 0 -5%")
  end, { description = "Decrease volume", group = "System" }),
  awful.key({ SUPER }, "F6", function()
    awful.spawn("pactl set-sink-volume 0 +5%")
  end, { description = "Increase volume", group = "System" }),
  awful.key({ SUPER }, "F7", function()
    awful.spawn("pactl set-sink-mute 0 toggle")
  end, { description = "Mute volume", group = "System" }),

  awful.key({ SUPER }, "F9", function()
    awful.spawn('nmcli radio all off && notify-send "Turned off wifi"')
  end, { description = "Turn off wifi", group = "System" }),
  awful.key({ SUPER }, "F10", function()
    awful.spawn('nmcli radio all on && notify-send "Turned on wifi"')
  end, { description = "Turn on wifi", group = "System" }),
}

-- ---------------------------------------------------------- --
-- #------------------ Client Keybindings ------------------# --
-- ---------------------------------------------------------- --
local client_keybindings = {
  awful.key({
    modifiers = { SUPER },
    key = "f",
    on_press = function(c)
      c.fullscreen = not c.fullscreen
      --c:raise()
    end,
    description = "Toggle fullscreen for focused program",
    group = "client",
  }),
  awful.key({
    modifiers = { SUPER },
    key = "c",
    on_press = function(c)
      c:kill()
    end,
    description = "Close focused program",
    group = "client",
  }),
  awful.key({
    modifiers = { SUPER },
    key = "space",
    on_press = awful.client.floating.toggle,
    description = "Toggle floating mode on focused program",
    group = "client",
  }),
  awful.key({
    modifiers = { SUPER, "Shift" },
    key = "s",
    on_press = function(c)
      c:swap(awful.client.getmaster())
    end,
    description = "Swap focused program with master (tile)",
    group = "client",
  }),
  awful.key({
    modifiers = { SUPER, "Control" },
    key = "t",
    on_press = function(c)
      c.ontop = not c.ontop
    end,
    description = "Toggle keep-on-top",
    group = "client",
  }),
  awful.key({
    modifiers = { SUPER },
    key = "i",
    on_press = function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    description = "Minimize focused program",
    group = "client",
  }),

  awful.key({
    modifiers = { SUPER },
    key = "m",
    on_press = function(c)
      c.maximized = not c.maximized
      --c.ontop = not c.ontop
      --c:raise()
    end,
    description = "Toggle maximize on focused program",
    group = "client",
  }),
}

-- ------------------------------------------------------------ --
-- #------------------ Global Mousebindings ------------------# --
-- ------------------------------------------------------------ --
local global_mousebindings = {
  awful.button({}, 3, function()
    mymainmenu:toggle()
  end),
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
}

-- ------------------------------------------------------------ --
-- #------------------ Client Mousebindings ------------------# --
-- ------------------------------------------------------------ --
local client_mousebindings = {
  awful.button({}, 1, function(c)
    c:activate({
      context = "mouse_click",
    })
  end),
  awful.button({ SUPER }, 1, function(c)
    c:activate({
      context = "mouse_click",
      action = "mouse_move",
    })
  end),
  awful.button({ SUPER }, 3, function(c)
    c:activate({
      context = "mouse_click",
      action = "mouse_resize",
    })
  end),
}

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings(client_keybindings)
end)

awful.keyboard.append_global_keybindings(global_keybindings)

awful.mouse.append_global_mousebindings(global_mousebindings)

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings(client_mousebindings)
end)
-- }}}
