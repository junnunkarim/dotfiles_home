from subprocess import run, Popen
from pathlib import Path

from .class_window_manager import Window_manager
from .class_menu import Menu
from .class_program_color import Program_color


class Dwm(Window_manager):
    def __init__(
        self,
        menu: Menu,
        wallpaper_dict: dict,
        colorscheme_dict: dict,
    ) -> None:
        # programs with universally defined location
        # ------------------------------------------
        alacritty = Program_color(
            file="~/.config/alacritty/colors.toml",
            start_concat='import = ["~/.config/alacritty/colorschemes/',
            end_concat='.toml"]',
        )

        btop = Program_color(
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
        gtk = Program_color(
            file="~/.config/gtk-3.0/settings.ini",
            start_concat="gtk-theme-name=",
            end_concat="",
            colorscheme_map=gtk_colorscheme_map,
        )
        helix = Program_color(
            file="~/.config/helix/config.toml",
            start_concat='theme = "',
            end_concat='"',
        )
        kitty = Program_color(
            file="~/.config/kitty/kitty.conf",
            start_concat="include ~/.config/kitty/colorschemes/",
            end_concat=".conf",
        )
        konsole = Program_color(
            file="~/.local/share/konsole/main.profile",
            start_concat="ColorScheme=",
            end_concat="",
        )
        zathura = Program_color(
            file="~/.config/zathura/zathurarc",
            start_concat="include colorschemes/",
            end_concat="",
        )

        # programs with user defined location
        # -----------------------------------
        dwm = Program_color(
            file="~/.Xresources",
            start_concat='#include ".config/dwm/xcolors_dwm/',
            end_concat='"',
        )
        dmenu = Program_color(
            file="~/.Xresources",
            start_concat='#include ".config/dmenu/xcolors_dmenu/',
            end_concat='"',
        )
        luastatus = Program_color(
            file="~/.config/dwm/luastatus/colorscheme/color.lua",
            start_concat='local color = require("',
            end_concat='")',
        )

        nvim_colorscheme_map = {
            "catppuccin_macchiato": "base16-catppuccin-macchiato",
            "dracula": "base16-dracula",
            "everblush": "everblush",
            "everforest": "base16-everforest",
            "gruvbox": "base16-gruvbox-dark-medium",
            "matugen": "base16-default-dark",
            "nord": "base16-nord",
            "rose_pine": "base16-rose-pine",
        }
        nvim = Program_color(
            file="~/.config/nvim/lua/core/colorscheme.lua",
            start_concat='local color = "',
            end_concat='"',
            colorscheme_map=nvim_colorscheme_map,
        )
        # rofi = Program_color(
        #     file="~/.config/dwm/external_configs/rofi/colors.rasi",
        #     start_concat=(
        #         f'@import "~/.config/dwm/external_configs/rofi/colorschemes/'
        #     ),
        #     end_concat='.rasi"',
        # )

        programs_to_manage = {
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
            # rofi,
        }

        super().__init__(menu, programs_to_manage, wallpaper_dict, colorscheme_dict)

    # ------------------------------------
    # functions for hot reloading programs
    # ------------------------------------
    def reload_dwm(
        self,
        xresource_path: Path = Path("~/.Xresources").expanduser(),
    ) -> None:
        xrdb_command = [
            "xrdb",
            "-merge",
            f"-I'$HOME'",
            f"{xresource_path}",
        ]

        run(xrdb_command)

        xsetroot_command = [
            "xsetroot",
            "-name",
            "fsignal:2",
        ]

        run(xsetroot_command)

        restart_luastatus = [
            f"{Path('~/.config/dwm/scripts/dwm_statusbar').expanduser()}",
        ]
        Popen(restart_luastatus, start_new_session=True)

    # -----------------------------------
    # functions for applying stuffs
    # -----------------------------------

    # for applying wallpaper
    # ----------------------
    def apply_wallpaper(
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

    def choose_and_apply_wallpaper(self):
        wallpaper = self._choose_wallpaper()

        self.apply_wallpaper(wallpaper)

    # for applying colorscheme
    # ------------------------
    def apply(
        self,
        choose_wallpaper=False,
    ):
        colorscheme = self._choose_colorscheme()
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

        if choose_wallpaper:
            selection = self._menu.get_confirmation(
                question="Do you want to choose a wallpaper?",
                positive=" Yes",
                negative=" No (random wallpaper choosen)",
            )

            if selection:
                wallpaper = self._choose_wallpaper()
            else:
                wallpaper = self._choose_random_wallpaper(colorscheme)
        else:
            wallpaper = self._choose_random_wallpaper(colorscheme)

        if colorscheme == "matugen":
            self.matugen_generate(wallpaper)

        super()._apply(colorscheme, allowed_programs)
        self.apply_wallpaper(wallpaper)
        self.apply_lockscreen_wallpaper(wallpaper)

        self.reload_dwm()
        self.reload_kitty()
