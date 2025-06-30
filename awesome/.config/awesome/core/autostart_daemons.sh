#!/bin/sh

run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

run "greenclip" daemon

# run "ibus-daemon" -rxRd

setxkbmap -option caps:escape
setxkbmap -model pc105 -layout us,us -variant dvorak, -option grp:shifts_toggle,grp_led:caps
