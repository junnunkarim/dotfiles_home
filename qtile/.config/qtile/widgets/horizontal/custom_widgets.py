from libqtile import widget
from libqtile.lazy import lazy

from core.helper import load_module
from custom.widgets import ExpandingClock
from options import default_colorscheme

colorscheme_module_path = f"themes.colorschemes.{default_colorscheme}.colors"
colors = load_module(colorscheme_module_path)


date_comp = {
    "sep1": widget.TextBox(
        background=colors.date_colors["bg_icon"],
    ),
    "icon": widget.TextBox(
        foreground=colors.date_colors["fg_icon"],
        background=colors.date_colors["bg_icon"],
        fontsize=35,
        # padding=5,
        fmt="󰃶",
    ),
    "sep2": widget.TextBox(
        background=colors.date_colors["bg_icon"],
    ),
    "value": ExpandingClock(
        foreground=colors.date_colors["fg"],
        background=colors.date_colors["bg"],
        fontsize=16,
        padding=10,
        format="%a %d-%m-%Y",
        # mouse_callbacks={
        #     "Button1": lazy.spawn(["alacritty", "-e", "calcure"]),
        # },
    ),
}

date = [
    date_comp["sep1"],
    date_comp["icon"],
    date_comp["sep2"],
    date_comp["value"],
]
