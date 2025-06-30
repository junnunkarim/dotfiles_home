import os

default_colorscheme = "gruvbox"
default_bar_type = "horizontal"  # currently vertical is not supported
default_font = "Iosevka Nerd Font Mono"

home = os.path.expanduser("~")
scripts = home + "/.config/qtile/scripts/"
wallpapers = home + "/.config/wallpaper/"

default_apps = {
    # default app launcher
    "app_launcher": scripts + "rofi_run",
    # default bluetooth manager
    "bluetooth_manager": "blueman-manager",
    # default clipboard manager
    "clipboard": scripts + "rofi_clip",
    # default file manager
    "file_manager": "thunar",
    # default terminal emulator
    "terminal": "kitty",
    # default text/code editor
    "text_editor": "kitty" + " nvim",
    # default web browser
    "web_browser": "chromium",
}

default_options = {
    "gaps_size": 10,
    "mod": "mod4",
    "alt": "mod1",
    "ctrl": "control",
}
