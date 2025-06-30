from themes.core_colorschemes import catppuccin

c = catppuccin

other_colors = {
    "light": c["text"],
    "gray": c["base"],
    "dark": c["crust"],
    "too_dark": c["crust"],
    "font": c["text"],
    "bg": c["crust"],
    "border": c["crust"],
}

# Widget c
app_launcher_colors = {
    "fg": c["crust"],
    "bg": c["yellow"],
}

tray_colors = {
    "fg": c["crust"],
    "fg_icon": c["crust"],
    "bg": c["blue"],
}

windowname_colors = {
    "fg": c["text"],
    "bg": c["crust"],
}

windowcount_colors = {
    "fg": c["crust"],
    "bg": c["maroon"],
}

groupbox_colors = {
    "bg": c["red"],
    "bg_focus": c["base"],
    "bg_urgent": c["mauve"],
    "fg_active": c["base"],
    "fg_inactive": c["flamingo"],
    "fg_focus": c["red"],
    "fg_urgent": c["base"],
}

layout_colors = {
    "bg": c["maroon"],
}

volume_colors = {
    "fg": c["crust"],
    "bg": c["mauve"],
}

brightness_colors = {
    "fg": c["crust"],
    "bg": c["red"],
}

network_colors = {
    "fg": c["crust"],
    "bg": c["green"],
}

widgetbox_colors = {
    "fg": c["yellow"],
    "bg": c["yellow"],
}

battery_colors = {
    "fg": c["crust"],
    "fg_icon": c["rosewater"],
    "fg_low": c["crust"],
    "bg": c["rosewater"],
    "bg_icon": c["surface1"],
    "bg_low": c["red"],
}

time_colors = {
    "fg": c["crust"],
    "fg_icon": c["yellow"],
    "bg": c["yellow"],
    "bg_icon": c["surface1"],
}

date_colors = {
    "fg": c["crust"],
    "fg_icon": c["peach"],
    "bg": c["peach"],
    "bg_icon": c["surface1"],
}

client_colors = {
    "border": c["crust"],
    "border_focus": c["maroon"],
    "border_floating": c["rosewater"],
}

bar_colors = {
    "bg": c["crust"],
    "border": c["crust"],
}
