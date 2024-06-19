from subprocess import run, Popen
from pathlib import Path

from .class_window_manager import Window_manager
from .class_menu import Menu, fail_exit


class Dwm(Window_manager):
    def __init__(
        self,
        menu: Menu,
        programs_to_manage: list | dict,
        wallpaper_dict: dict,
        colorscheme_dict: dict,
    ) -> None:
        super().__init__(menu, programs_to_manage, wallpaper_dict, colorscheme_dict)

    # ---------------------------------------------------------------
    # functions for changing gui/cli application colorschemes/themes
    # ---------------------------------------------------------------

    # programs with user defined location
    # -----------------------------------

    def change_dwm_color(
        self,
        colorscheme: str,
        file_path: Path = Path("~/.Xresources").expanduser(),
    ) -> None:
        if not file_path.is_file():
            fail_exit(error=f"File path - '{file_path}' is not found!")

        start_concatenate = '#include ".config/dwm/xcolors_dwm/'
        end_concatenate = '"'

        self.replace_string(colorscheme, start_concatenate, end_concatenate, file_path)

    def change_dmenu_color(
        self,
        colorscheme: str,
        file_path: Path = Path("~/.Xresources").expanduser(),
    ) -> None:
        if not file_path.is_file():
            fail_exit(error=f"File path - '{file_path}' is not found!")

        start_concatenate = '#include ".config/dmenu/xcolors_dmenu/'
        end_concatenate = '"'

        self.replace_string(colorscheme, start_concatenate, end_concatenate, file_path)

    def change_luastatus_color(
        self,
        colorscheme: str,
        file_path: Path = Path(
            "~/.config/dwm/luastatus/colorscheme/color.lua"
        ).expanduser(),
    ) -> None:
        if not file_path.is_file():
            fail_exit(error=f"File path - '{file_path}' is not found!")

        start_concatenate = 'local color = require("'
        end_concatenate = '")'

        self.replace_string(colorscheme, start_concatenate, end_concatenate, file_path)

    def rofi_color(
        self,
        colorscheme: str,
        file_path: Path = Path(
            "~/.config/dwm/external_configs/rofi/colors.rasi"
        ).expanduser(),
    ) -> None:
        if not file_path.is_file():
            fail_exit(error=f"File path - '{file_path}' is not found!")

        start_concatenate = (
            f'@import "~/.config/dwm/external_configs/rofi/colorschemes/'
        )
        end_concatenate = '.rasi"'

        self.replace_string(colorscheme, start_concatenate, end_concatenate, file_path)

    # ------------------------------------
    # functions for hot reloading programs
    # ------------------------------------
    def reload_dwm(
        self, xresource_path: Path = Path("~/.Xresources").expanduser()
    ) -> None:
        xrdb_command = [
            "xrdb",
            "-merge",
            f"-I'$HOME'",
            f"{xresource_path}",
        ]

        run(xrdb_command, text=True, check=False)

        xsetroot_command = [
            "xsetroot",
            "-name",
            "fsignal:2",
        ]

        run(xsetroot_command, text=True, check=False)

        restart_luastatus = [
            f"{Path('~/.config/dwm/scripts/dwm_statusbar').expanduser()}",
        ]
        Popen(restart_luastatus, start_new_session=True)

    # -----------------------------------
    # functions for applying stuffs
    # -----------------------------------

    # for applying wallpaper
    # ----------------------
    def apply_wallpaper(self, wallpaper: str) -> None:
        wallpaper_path = Path("~/.config/wallpaper/" + wallpaper).expanduser()

        command = ["feh", "--bg-fill", wallpaper_path]

        Popen(command, start_new_session=True)

    def apply_lockscreen_wallpaper(self, wallpaper: str) -> None:
        wallpaper_path = Path("~/.config/wallpaper/" + wallpaper).expanduser()

        command = ["betterlockscreen", "--fx", " ", "-u", wallpaper_path]

        Popen(command, start_new_session=True)

    def choose_and_apply_wallpaper(self):
        wallpaper = self._choose_wallpaper()

        self.apply_wallpaper(wallpaper)

    # for applying colorscheme
    # ------------------------
    def apply(self, choose_wallpaper=False):
        colorscheme = self._choose_colorscheme()
        super()._apply(colorscheme)

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

        self.reload_dwm()
        self.reload_kitty()
