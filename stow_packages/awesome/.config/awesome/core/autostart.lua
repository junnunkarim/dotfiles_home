local awful = require("awful")


local function autostart_programs()
  --awful.spawn.with_shell("setxkbmap -option caps:escape")
  --awful.spawn.with_shell("setxkbmap -model pc105 -layout us,us -variant dvorak, -option grp:shifts_toggle,grp_led:caps")
  awful.spawn.single_instance("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
  --awful.spawn.single_instance("polkit-gnome-authentication-agent-1")
  --awful.spawn.single_instance("xfce4-power-manager")
  awful.spawn.single_instance("picom -b")
  awful.spawn.single_instance("redshift -P -O 5500")

  awful.spawn.with_shell("~/.config/awesome/core/autostart_daemons.sh")
end

autostart_programs()
