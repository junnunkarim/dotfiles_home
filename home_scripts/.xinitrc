#!/bin/bash

session=${1:-qtile}

[[ -f ~/.Xresources ]] && xrdb -merge -I"$HOME" ~/.Xresources

case $session in
dwm)
  # exec dwm 2>~/.dwm.log
  exec dwm
  ;;
bspwm)
  exec bspw
  ;;
awesome)
  exec awesome
  ;;
qtile)
  qtile start
  ;;
qtile_wayland)
  unset "$WAYLAND_DISPLAY"
  qtile start -b wayland
  ;;
*)
  exec $1
  ;;
esac
