[[ -f ~/.Xresources  ]] && xrdb -merge -I$HOME ~/.Xresources

dwm_statusbar_wrapper &
