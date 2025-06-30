import os

from libqtile.config import Click, Drag, Key
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from options import default_apps, default_options


# Credit - user NaBaCo on IRC
def show_keybindings(keys):
    key_help = ""
    for k in keys:
        mods = ""

        for m in k.modifiers:
            if m == "mod4":
                mods += "Super + "
            else:
                mods += m.capitalize() + " + "

        if len(k.key) > 1:
            mods += k.key.capitalize()
        else:
            mods += k.key

        key_help += "{:<40} {}".format(mods, k.desc + "\n")

    return key_help


mod, alt, ctrl = (
    default_options["mod"],
    default_options["alt"],
    default_options["ctrl"],
)

terminal = default_apps["terminal"] or guess_terminal()
file_manager = default_apps["file_manager"]
text_editor = default_apps["text_editor"]
web_browser = default_apps["web_browser"]

home = os.path.expanduser("~")
scripts = home + "/.config/qtile/scripts/"

keys = [
    ##---------- System (super [+ shift]) ----------##
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key(
        [mod, alt],
        "c",
        lazy.spawn(terminal + " --class=editor_cli"),
        desc="Launch terminal for coding",
    ),
    # toggles
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen",
    ),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod], "b", lazy.hide_show_bar(), desc="Toggle visibility of the bar"),
    Key(
        [mod, "shift"],
        "w",
        lazy.widget["infobox"].toggle(),
        desc="Toggle more widgets visibility",
    ),
    Key(
        [mod, "shift"],
        "t",
        lazy.widget["traybox"].toggle(),
        desc="Toggle tray visibility",
    ),
    # cycle through windows and groups
    Key(
        [mod],
        "Tab",
        lazy.screen.next_group(skip_empty=True),
        desc="Cycle through active groups clockwise",
    ),
    Key(
        [mod],
        "grave",
        lazy.screen.prev_group(skip_empty=True),
        desc="Cycle through active groups anti-clockwise",
    ),
    Key(
        [alt],
        "Tab",
        lazy.group.next_window(),
        lazy.window.move_up(),
        desc="Cycle through windows of current group clockwise",
    ),
    Key(
        [alt],
        "grave",
        lazy.group.prev_window(),
        lazy.window.move_up(),
        desc="Cycle through windows of current group anti-clockwise",
    ),
    Key(
        [mod, ctrl, "shift"],
        "space",
        lazy.next_layout(),
        desc="Cycle between layouts",
    ),
    Key([mod], "c", lazy.window.kill(), desc="Close/quit focused window"),
    Key(
        [mod],
        "i",
        lazy.window.toggle_minimize(),
        desc="Toggle minimize of focused window",
    ),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload Qtile config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "l", lazy.spawn("betterlockscreen -l"), desc="Lock screen"),
    # rofi menus
    Key(
        [mod],
        "d",
        lazy.spawn([scripts + "rofi_run"]),
        desc="Open app-launcher",
    ),
    Key(
        [mod],
        "x",
        lazy.spawn([scripts + "powermenu"]),
        desc="Open powermenu",
    ),
    Key(
        [mod],
        "h",
        lazy.spawn([scripts + "rofi_clip"]),
        desc="Open clipboard",
    ),
    Key(
        [mod],
        "r",
        lazy.spawn([scripts + "rofi_calc"]),
        desc="Open calculator",
    ),
    Key(
        [mod, "shift"],
        "b",
        lazy.spawn([scripts + "rofi_buku"]),
        desc="Open bookmark manager (buku)",
    ),
    Key(
        [mod],
        "e",
        lazy.spawn([scripts + "rofi_emoji"]),
        desc="Open emoji-selector",
    ),
    Key(
        [mod],
        "t",
        lazy.spawn([scripts + "change_colorscheme.py"]),
        desc="Open Colorscheme-switcher",
    ),
    Key([mod], "n", lazy.spawn("networkmanager_dmenu"), desc="Open network manager"),
    ##---------- System Keys ----------##
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn('brightnessctl -d "intel_backlight" set +2%'),
        desc="Raise brightness",
    ),
    Key(
        [mod],
        "F2",
        lazy.spawn('brightnessctl -d "intel_backlight" set +2%'),
        desc="Raise brightness",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn('brightnessctl -d "intel_backlight" set 2%-'),
        desc="Lower brightness",
    ),
    Key(
        [mod],
        "F1",
        lazy.spawn('brightnessctl -d "intel_backlight" set 2%-'),
        desc="Lower brightness",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        # lazy.spawn("pactl set-sink-volume 0 -2%"),
        lazy.spawn("pulsemixer --change-volume -5 --max-volume 100"),
        desc="Lower volume",
    ),
    Key(
        [mod],
        "F5",
        lazy.spawn("pulsemixer --change-volume -5 --max-volume 100"),
        desc="Lower volume",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        # lazy.spawn("pactl set-sink-volume 0 +2%"),
        lazy.spawn("pulsemixer --change-volume +5 --max-volume 100"),
        desc="Raise volume",
    ),
    Key(
        [mod],
        "F6",
        lazy.spawn("pulsemixer --change-volume +5 --max-volume 100"),
        desc="Raise volume",
    ),
    Key(
        [],
        "XF86AudioMute",
        # lazy.spawn("pactl set-sink-mute 0 toggle"),
        lazy.spawn("pulsemixer --toggle-mute"),
        desc="Mute volume",
    ),
    Key([mod], "F7", lazy.spawn("pulsemixer --toggle-mute"), desc="Mute volume"),
    Key(
        [],
        "Print",
        lazy.spawn(["flameshot", "full", "-p", home + "/pictures/ss/"]),
        desc="Take screenshot",
    ),
    Key([mod], "Print", lazy.spawn("flameshot gui"), desc="Open flameshot (gui)"),
    Key(
        [alt],
        "Print",
        lazy.spawn(["flameshot", "full", "-d", "5000", "-p", home + "/pictures/ss/"]),
        desc="Take screenshot after 5 seconds",
    ),
    Key(
        ["shift"],
        "Print",
        lazy.spawn(["flameshot", "full", "-d", "10000", "-p", home + "/pictures/ss/"]),
        desc="Take screenshot after 10 seconds",
    ),
    ##---------- Applications (super + alt) ----------##
    # web browser
    Key([mod, alt], "b", lazy.spawn(web_browser), desc="Open default web browser"),
    Key([mod, alt], "e", lazy.spawn("firefox"), desc="Open firefox"),
    # file manager
    Key([mod, alt], "t", lazy.spawn(file_manager), desc="Open file manager (thunar)"),
    # cli programs
    # Key(
    #     [mod, alt],
    #     "n",
    #     lazy.spawn([home + "/.bin/nnn_run"]),
    #     desc="Open NNN file manager",
    # ),
    Key(
        [mod, alt],
        "f",
        lazy.spawn("kitty --class felix fx"),
        desc="Open TUI file manager (felix)",
    ),
    Key([mod, alt], "v", lazy.spawn(text_editor), desc="Open text editor (neovim)"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    # Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    # Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    # Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    # Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, ctrl], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, ctrl], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, ctrl], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, ctrl], "k", lazy.layout.grow_up(), desc="Grow window up"),
    # Key([mod, ctrl], "space", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    ##---------- Other programs or scripts (super + ctrl) ----------##
    # bluelight filter
    Key(
        [mod, ctrl],
        "r",
        lazy.spawn("redshift -P -O 5000"),
        desc="Turn on bluelight filter",
    ),
    Key([mod, ctrl], "n", lazy.spawn("redshift -x"), desc="Turn on bluelight filter"),
    Key(
        [mod, ctrl],
        "v",
        lazy.spawn("redshift -P -O 3500"),
        desc="Turn on bluelight filter (intense)",
    ),
    # X11 compositor
    Key([mod, ctrl], "p", lazy.spawn("picom"), desc="Turn on compositor (picom)"),
    Key(
        [mod, ctrl], "u", lazy.spawn("pkill picom"), desc="Turn off compositor (picom)"
    ),
    Key([mod, ctrl], "g", lazy.spawn("gpick -p"), desc="Open color-picker"),
]

keys.extend(
    [
        Key(
            [mod],
            "k",
            lazy.spawn(
                "sh -c 'echo \""
                + show_keybindings(keys)
                + '" | rofi -dmenu -i -theme $HOME/.config/qtile/external_configs/rofi/script_menu_1.rasi -p "󰌌" -mesg "Keyboard shortcuts"\''
            ),
            desc="Show keybindings",
        ),
    ]
)

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]
