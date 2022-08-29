#!/bin/sh

/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session &

[[ -f ~/.Xresources  ]] && xrdb -merge -I$HOME ~/.Xresources

~/.bin/./dwm_statusbar_wrapper &
