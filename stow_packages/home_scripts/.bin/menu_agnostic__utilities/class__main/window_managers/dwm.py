import sys
import os

from subprocess import Popen
from pathlib import Path

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from class__base.window_manager.base import WindowManager
from class__base.menu.base import Menu
from class__base.program_color.base import ProgramColor

from helpers.colorscheme import matugen_gen_color
from helpers.reload_function import reload_dwm, reload_kitty, reload_konsole


class Dwm(WindowManager):
    manage_programs: dict[str, ProgramColor]

    def __init__(
        self,
        menu: Menu,
        wallpaper_dict: dict,
        colorscheme_dict: dict,
    ) -> None:
        # programs with universally defined location
        # ------------------------------------------
        alacritty = ProgramColor(
            file="~/.config/alacritty/colors.toml",
            start_concat='import = ["~/.config/alacritty/colorschemes/',
            end_concat='.toml"]',
        )

        btop = ProgramColor(
            file="~/.config/btop/btop.conf",
            start_concat='color_theme = "',
            end_concat='"',
            colorscheme_map={
                "catppuccin_macchiato": "catppuccin_macchiato",
                "dracula": "dracula",
                "everblush": "everblush",
                "everforest": "everforest",
                "gruvbox": "gruvbox",
                "matugen": "Default",
                "nord": "nord",
                "rose_pine": "rose_pine",
            },
        )

        gtk_colorscheme_map = {
            "catppuccin_macchiato": "catppuccin_macchiato",
            "dracula": "dracula",
            "everblush": "everblush",
            "everforest": "everforest",
            "gruvbox": "gruvbox",
            "matugen": "materia",
            "nord": "nord",
            "rose_pine": "rose_pine",
        }
        gtk = ProgramColor(
            file="~/.config/gtk-3.0/settings.ini",
            start_concat="gtk-theme-name=",
            end_concat="",
            colorscheme_map=gtk_colorscheme_map,
        )
        helix = ProgramColor(
            file="~/.config/helix/config.toml",
            start_concat='theme = "',
            end_concat='"',
        )
        kitty = ProgramColor(
            file="~/.config/kitty/kitty.conf",
            start_concat="include ~/.config/kitty/colorschemes/",
            end_concat=".conf",
        )
        konsole = ProgramColor(
            file="~/.local/share/konsole/main.profile",
            start_concat="ColorScheme=",
            end_concat="",
        )
        zathura = ProgramColor(
            file="~/.config/zathura/zathurarc",
            start_concat="include colorschemes/",
            end_concat="",
        )

        # programs with user defined location
        # -----------------------------------
        dwm = ProgramColor(
            file="~/.Xresources",
            start_concat='#include ".config/dwm/xcolors_dwm/',
            end_concat='"',
        )
        dmenu = ProgramColor(
            file="~/.Xresources",
            start_concat='#include ".config/dmenu/xcolors_dmenu/',
            end_concat='"',
        )
        luastatus = ProgramColor(
            file="~/.config/dwm/luastatus/colorscheme/color.lua",
            start_concat='local color = require("',
            end_concat='")',
        )

        nvim = ProgramColor(
            file="~/.config/nvim/lua/core/colorscheme.lua",
            start_concat='local color = "',
            end_concat='"',
            colorscheme_map={
                "catppuccin_macchiato": "base16-catppuccin-macchiato",
                "dracula": "base16-dracula",
                "everblush": "everblush",
                "everforest": "base16-everforest",
                "gruvbox": "base16-gruvbox-dark-medium",
                "matugen": "base16-default-dark",
                "nord": "base16-nord",
                "rose_pine": "base16-rose-pine",
            },
        )
        # rofi = ProgramColor(
        #     file="~/.config/dwm/external_configs/rofi/colors.rasi",
        #     start_concat=(
        #         f'@import "~/.config/dwm/external_configs/rofi/colorschemes/'
        #     ),
        #     end_concat='.rasi"',
        # )

        manage_programs = {
            "alacritty": alacritty,
            "btop": btop,
            "gtk": gtk,
            "helix": helix,
            "kitty": kitty,
            "konsole": konsole,
            "zathura": zathura,
            "dwm": dwm,
            "dmenu": dmenu,
            "luastatus": luastatus,
            "nvim": nvim,
        }

        self.manage_programs = manage_programs

        super().__init__(menu, wallpaper_dict, colorscheme_dict)

    # -----------------------------------
    # functions for applying stuffs
    # -----------------------------------

    # for applying wallpaper
    # ----------------------
    def apply_desktop_wallpaper(
        self,
        wallpaper: str,
    ) -> None:
        wallpaper_path = Path("~/.config/wallpaper/" + wallpaper).expanduser()

        command = ["feh", "--bg-fill", wallpaper_path]

        Popen(command, start_new_session=True)

    def apply_lockscreen_wallpaper(
        self,
        wallpaper: str,
    ) -> None:
        wallpaper_path = Path("~/.config/wallpaper/" + wallpaper).expanduser()

        command = ["betterlockscreen", "--fx", " ", "-u", wallpaper_path]

        Popen(command, start_new_session=True)

    # for applying colorscheme
    # ------------------------
    def apply(
        self,
        choose_wallpaper=False,
    ):
        allowed_programs = {
            "matugen": [
                "btop",
                "dwm",
                "dmenu",
                "gtk",
                "luastatus",
                "kitty",
                "nvim",
            ],
        }

        apply_wallpaper_functions = [
            self.apply_desktop_wallpaper,
            self.apply_lockscreen_wallpaper,
        ]

        reload_programs = {
            reload_dwm: {},
            reload_kitty: {},
            reload_konsole: {"replace": ["colorscheme"], "params": ["main"]},
        }

        self._apply(
            matugen_gen_color,
            self.manage_programs,
            reload_programs,
            choose_wallpaper,
            apply_wallpaper_functions,
            allowed_programs,
        )
