#!/bin/bash

session=${1:-dwm}

[[ -f ~/.Xresources  ]] && xrdb -merge -I"$HOME" ~/.Xresources

case $session in
    dwm )
      /usr/bin/pipewire &
      /usr/bin/pipewire-pulse &
      /usr/bin/pipewire-media-session &

      ~/.bin/dwm/./dwm_statusbar_wrapper &

      exec dwm 2> ~/.dwm.log
      ;;
    bspwm )
      exec bspw
      ;;
    awesome )
      exec awesome
      ;;
    qtile )
      qtile start
      ;;
    qtile_wayland )
      unset "$WAYLAND_DISPLAY"
      qtile start -b wayland
      ;;
    * )
      exec $1
      ;;
esac
