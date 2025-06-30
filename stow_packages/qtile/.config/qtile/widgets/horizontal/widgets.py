import os

from libqtile import widget
from libqtile.lazy import lazy

from core.helper import load_module
from options import default_colorscheme, default_font

colorscheme_module_path = f"themes.colorschemes.{default_colorscheme}.colors"
colors = load_module(colorscheme_module_path)

home = os.path.expanduser("~")
scripts = home + "/.config/qtile/scripts/"


# widget components
# -----------------

app_launcher_comp = widget.TextBox(
    foreground=colors.app_launcher_colors["fg"],
    background=colors.app_launcher_colors["bg"],
    fontsize=40,
    padding=10,
    # margin=3,
    # fmt="󰣇",
    fmt="󰕰",
    font=default_font,
    mouse_callbacks={
        "Button1": lazy.spawn([scripts + "rofi_run"]),
    },
)

windowname_comp = widget.WindowName(
    foreground=colors.windowname_colors["fg"],
    background=colors.windowname_colors["bg"],
    fontsize=16,
    width=450,
    padding=10,
    # max_chars=50,
    # empty_group_string="╮(︶︿︶)╭  Nothing to See... ┬┴┬┴┤(･_├┬┴┬┴",
    fmt=" <i><b>{}</b></i>",
    scroll=True,
    scroll_interval=0.02,
    scroll_delay=1,
)

client_count_comp = widget.WindowCount(
    background=colors.windowcount_colors["bg"],
    foreground=colors.windowcount_colors["fg"],
    fontsize=18,
    padding=5,
    show_zero=True,
    fmt="╹{}╻",
)

groups_comp = widget.GroupBox(
    active=colors.groupbox_colors["fg_active"],  # active group font colour
    inactive=colors.groupbox_colors["fg_inactive"],  # inactive group font colour
    block_highlight_text_color=colors.groupbox_colors[
        "fg_focus"
    ],  # selected group font colour
    urgent_text=colors.groupbox_colors["fg_urgent"],  # urgent group font color
    #
    background=colors.groupbox_colors["bg"],  # widget background color
    this_current_screen_border=colors.groupbox_colors[
        "bg_focus"
    ],  # border or line colour for group on this screen when focused.
    urgent_border=colors.groupbox_colors["bg_urgent"],  # urgent border or line color
    #
    fontsize=30,
    padding=10,
    highlight_method="block",
    hide_unused=False,
    disable_drag=True,
    # highlight_color=[color["green0"], color["green2"]],
    # this_screen_border=color["green2"],
)

layout_icon_comp = widget.CurrentLayoutIcon(
    background=colors.layout_colors["bg"],
    scale=1.0,
)

volume_comp = {
    "sep1": widget.TextBox(
        background=colors.volume_colors["bg"],
    ),
    "icon": widget.TextBox(
        foreground=colors.volume_colors["fg"],
        background=colors.volume_colors["bg"],
        fontsize=26,
        # padding=5,
        fmt="󰓃",
        mouse_callbacks={
            "button1": lazy.spawn(["kitty", "alsamixer"]),
        },
    ),
    "value": widget.Volume(
        foreground=colors.volume_colors["fg"],
        background=colors.volume_colors["bg"],
        padding=10,
        # emoji=true,
        fmt="{}",
        mouse_callbacks={
            "button1": lazy.spawn(["kitty", "alsamixer"]),
        },
    ),
}

backlight_comp = {
    "sep1": widget.TextBox(
        background=colors.brightness_colors["bg"],
    ),
    "icon": widget.TextBox(
        foreground=colors.brightness_colors["fg"],
        background=colors.brightness_colors["bg"],
        fontsize=26,
        # padding=5,
        fmt="󰃝",
    ),
    "value": widget.Backlight(
        foreground=colors.brightness_colors["fg"],
        background=colors.brightness_colors["bg"],
        padding=10,
        # emoji=true,
        backlight_name="intel_backlight",
    ),
}

network_comp = {
    "sep1": widget.TextBox(
        background=colors.network_colors["bg"],
    ),
    "icon": widget.TextBox(
        foreground=colors.network_colors["fg"],
        background=colors.network_colors["bg"],
        fontsize=26,
        # padding=5,
        fmt="󰤥",
        mouse_callbacks={
            "button1": lazy.spawn("networkmanager_dmenu"),
        },
    ),
    "value": widget.Wlan(
        foreground=colors.network_colors["fg"],
        background=colors.network_colors["bg"],
        # max_chars=12,
        padding=10,
        width=90,
        scroll=True,
        scroll_interval=0.05,
        format="{essid}",
        interface="wlp1s0",
        mouse_callbacks={
            "button1": lazy.spawn("networkmanager_dmenu"),
        },
    ),
}

battery_comp = {
    "sep1": widget.TextBox(
        background=colors.battery_colors["bg_icon"],
    ),
    "icon": widget.TextBox(
        foreground=colors.battery_colors["fg_icon"],
        background=colors.battery_colors["bg_icon"],
        fmt="",
        fontsize=35,
        # padding=10,
    ),
    "sep2": widget.TextBox(
        background=colors.battery_colors["bg_icon"],
    ),
    "value": widget.Battery(
        foreground=colors.battery_colors["fg"],
        low_foreground=colors.battery_colors["fg_low"],
        background=colors.battery_colors["bg"],
        low_boreground=colors.battery_colors["bg_low"],
        charge_char="󱐋",
        discharge_char="",
        full_char="",
        notify_below=15,
        notification_timeout=20,
        fontsize=16,
        padding=10,
        format="{char}{percent:2.0%}",
        fmt="<b>{}</b>",
        # mouse_callbacks={
        #     "Button1": lazy.spawn("xfce4-power-manager-settings"),
        # },
    ),
}

time_comp = {
    "sep1": widget.TextBox(
        background=colors.time_colors["bg_icon"],
    ),
    "icon": widget.TextBox(
        foreground=colors.time_colors["fg_icon"],
        background=colors.time_colors["bg_icon"],
        fmt="",
        fontsize=35,
        # padding=10,
    ),
    "sep2": widget.TextBox(
        background=colors.time_colors["bg_icon"],
    ),
    "value": widget.Clock(
        background=colors.time_colors["bg"],
        foreground=colors.time_colors["fg"],
        fontsize=16,
        padding=10,
        format="%I:%M %p",
        fmt="<b>{}</b>",
        font=default_font,
        mouse_callbacks={
            "Button1": lazy.spawn(["kitty", "calcure"]),
        },
    ),
}

date_comp = {
    "sep1": widget.TextBox(
        background=colors.date_colors["bg_icon"],
    ),
    "icon": widget.TextBox(
        foreground=colors.date_colors["fg_icon"],
        background=colors.date_colors["bg_icon"],
        fmt="󰃶",
        fontsize=26,
        # padding=5,
    ),
    "sep2": widget.TextBox(
        background=colors.date_colors["bg_icon"],
    ),
    "value": widget.Clock(
        foreground=colors.date_colors["fg"],
        background=colors.date_colors["bg"],
        fontsize=16,
        padding=10,
        format="%a %d-%m-%Y",
        fmt="<b>{}</b>",
        mouse_callbacks={
            "Button1": lazy.spawn(["kitty", "calcure"]),
        },
    ),
}


# widget lists
# ------------

separator_auto = [widget.Spacer()]

separator_small = [
    widget.Spacer(
        length=10,
    )
]

app_launcher = [app_launcher_comp]

windowname = [windowname_comp]

client_count = [client_count_comp]

groups = [groups_comp]

layout_icon = [layout_icon_comp]

battery = [
    battery_comp["sep1"],
    battery_comp["icon"],
    battery_comp["sep2"],
    battery_comp["value"],
]

time = [
    time_comp["sep1"],
    time_comp["icon"],
    time_comp["sep2"],
    time_comp["value"],
]

date = [
    date_comp["sep1"],
    date_comp["icon"],
    date_comp["sep2"],
    date_comp["value"],
]

volume = [
    volume_comp["sep1"],
    volume_comp["icon"],
    volume_comp["value"],
]

backlight = [
    backlight_comp["sep1"],
    backlight_comp["icon"],
    backlight_comp["value"],
]

network = [
    network_comp["sep1"],
    network_comp["icon"],
    network_comp["value"],
]

tray = [
    widget.WidgetBox(
        name="traybox",
        foreground=colors.tray_colors["bg"],
        fontsize=30,
        text_closed="",
        text_open="",
        close_button_location="left",
        widgets=separator_small
        + [
            widget.Systray(
                background=colors.tray_colors["bg"],
                padding=5,
            ),
        ]
        + [
            widget.TextBox(
                background=colors.tray_colors["bg"],
            ),
        ],
    )
]

widgetbox_info = [
    widget.WidgetBox(
        name="infobox",
        foreground=colors.widgetbox_colors["fg"],
        fontsize=25,
        # padding=10,
        text_closed="",  # 󰸳
        text_open="",  # 󰸶
        # text_closed="",
        # text_open="",
        close_button_location="right",
        widgets=volume
        + separator_small
        + backlight
        + separator_small
        + network
        + separator_small,
    )
]
