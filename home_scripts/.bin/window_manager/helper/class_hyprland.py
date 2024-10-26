from subprocess import run, Popen
from pathlib import Path

from .class_window_manager import Window_manager
from .class_menu import Menu
from .class_program_color import Program_color


class Hyprland(Window_manager):
    def __init__(
        self,
        menu: Menu,
        wallpaper_dict: dict,
        colorscheme_dict: dict,
    ) -> None:
        # programs with universally defined location
        # ------------------------------------------
        btop_colorscheme_map = {
            "catppuccin_macchiato": "catppuccin_macchiato",
            "dracula": "dracula",
            "everblush": "everblush",
            "everforest": "everforest",
            "gruvbox": "gruvbox",
            "matugen": "TTY",
            "nord": "nord",
            "rose_pine": "rose_pine",
        }
        btop = Program_color(
            file="~/.config/btop/btop.conf",
            start_concat='color_theme = "',
            end_concat='"',
            colorscheme_map=btop_colorscheme_map,
        )

        gtk_colorscheme_map = {
            "catppuccin_macchiato": "catppuccin_macchiato",
            "dracula": "dracula",
            "everblush": "everblush",
            "everforest": "everforest",
            "gruvbox": "gruvbox",
            "matugen": "adw-gtk3",
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
        hyprland = Program_color(
            file="~/.config/hypr/external_configs/ags/user_options.json",
            start_concat='  "colorscheme": "',
            end_concat='"',
        )
        # dmenu = Program_color(
        #     file="~/.Xresources",
        #     start_concat='#include ".config/dmenu/xcolors_dmenu/',
        #     end_concat='"',
        # )

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

        programs_to_manage = {
            "btop": btop,
            "gtk": gtk,
            "helix": helix,
            "kitty": kitty,
            "konsole": konsole,
            "zathura": zathura,
            "hyprland": hyprland,
            "nvim": nvim,
        }

        super().__init__(menu, programs_to_manage, wallpaper_dict, colorscheme_dict)

    # ------------------------------------
    # functions for hot reloading programs
    # ------------------------------------
    # def reload_dwm(
    #     self,
    #     xresource_path: Path = Path("~/.Xresources").expanduser(),
    # ) -> None:
    #     xrdb_command = [
    #         "xrdb",
    #         "-merge",
    #         f"-I'$HOME'",
    #         f"{xresource_path}",
    #     ]
    #
    #     run(xrdb_command)
    #
    #     xsetroot_command = [
    #         "xsetroot",
    #         "-name",
    #         "fsignal:2",
    #     ]
    #
    #     run(xsetroot_command)
    #
    #     restart_luastatus = [
    #         f"{Path('~/.config/dwm/scripts/dwm_statusbar').expanduser()}",
    #     ]
    #     Popen(restart_luastatus, start_new_session=True)

    # -----------------------------------
    # functions for applying stuffs
    # -----------------------------------

    # for applying wallpaper
    # ----------------------
    def apply_wallpaper(
        self,
        wallpaper: str,
    ) -> None:
        command = [
            f'{Path("~/.config/hypr/scripts/change_wallpaper.py").expanduser()}',
            "--wallpaper",
            wallpaper,
        ]

        output = Popen(command, start_new_session=True)

        print(output)

    def apply_lockscreen_wallpaper(
        self,
        wallpaper: str,
    ) -> None:
        lock_wall = Program_color(
            file="~/.config/hypr/hyprlock.conf",
            start_concat="$lockscreen_wall = ",
            end_concat="",
        )
        wallpaper_path = "~/.config/wallpaper/" + wallpaper

        lock_wall.apply(wallpaper_path)

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
        super()._apply(colorscheme, allowed_programs)

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

        self.apply_wallpaper(wallpaper)
        self.apply_lockscreen_wallpaper(wallpaper)

        # self.reload_dwm()
        self.reload_kitty()
