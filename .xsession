# Changes Caps-Lock to Escape
setxkbmap -option caps:escape

# Changes keyboard layout and modifier key
setxkbmap -model pc105 -layout us,us -variant dvorak, -option grp:shifts_toggle,grp_led:caps

~/.bin/dwm/./dwm_statusbar_wrapper &
