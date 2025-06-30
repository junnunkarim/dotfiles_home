#!/bin/sh

run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "fcitx5"
run "picom" -b
run "greenclip" daemon
redshift -P -O 5000
# run "xsettingsd"

# change mouse acceleration
# xinput --set-prop 10 'libinput Accel Speed'  0.2
