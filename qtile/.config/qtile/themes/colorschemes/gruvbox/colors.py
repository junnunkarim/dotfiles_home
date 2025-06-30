from themes.core_colorschemes import gruvbox

c = gruvbox

other_colors = {
    "light": c["white"],
    "gray": c["gray1"],
    "dark": c["black"],
    "too_dark": c["black0"],
    "font": c["white"],
    "bg": c["black"],
    "border": c["black"],
}

# Widget Colors
app_launcher_colors = {
    "fg": c["black"],
    "bg": c["green2"],
}

tray_colors = {
    "fg": ["black"],
    "fg_icon": c["black"],
    "bg": c["purple2"],
}

windowname_colors = {
    "fg": c["white"],
    "bg": c["black"],
}

windowcount_colors = {
    "fg": c["black"],
    "bg": c["blue2"],
}

groupbox_colors = {
    "bg": c["orange2"],
    "bg_focus": c["orange1"],
    "bg_urgent": c["orange2"],
    "fg_active": c["black"],
    "fg_inactive": c["orange1"],
    "fg_focus": c["black"],
    "fg_urgent": c["red1"],
}

layout_colors = {
    "bg": c["blue2"],
}

volume_colors = {
    "fg": c["black"],
    "bg": c["red2"],
}

brightness_colors = {
    "fg": c["black"],
    "bg": c["purple2"],
}

network_colors = {
    "fg": c["black"],
    "bg": c["green2"],
}

widgetbox_colors = {
    "fg": c["red1"],
    "bg": c["red1"],
}

battery_colors = {
    "fg": c["black"],
    "fg_icon": c["black"],
    "fg_low": c["red1"],
    "bg": c["blue2"],
    "bg_icon": c["blue1"],
    "bg_low": c["red2"],
}

time_colors = {
    "fg": c["black"],
    "fg_icon": c["black"],
    "bg": c["aqua2"],
    "bg_icon": c["aqua1"],
}

date_colors = {
    "fg": c["black"],
    "fg_icon": c["black"],
    "bg": c["yellow2"],
    "bg_icon": c["yellow1"],
}

client_colors = {
    "border": c["black"],
    "border_focus": c["orange2"],
    "border_floating": c["green2"],
}

bar_colors = {
    "bg": c["black"],
    "border": c["black"],
}
