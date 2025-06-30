import sys
import os
import random

from getpass import getuser
from collections.abc import Callable

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from menu.base import Menu
from program_color.base import ProgramColor


class WindowManager:
    menu: Menu
    username: str = getuser()
    # key is the colorscheme name and value is the wallpaper filename list
    wallpaper_dict: dict[str, list]
    # key is the colorscheme name and value is the string format to show to user
    colorscheme_dict: dict[str, str]

    def __init__(
        self,
        menu: Menu,
        wallpaper_dict: dict,
        colorscheme_dict: dict,
    ) -> None:
        self.menu = menu

        self.wallpaper_dict = wallpaper_dict
        self.colorscheme_dict = colorscheme_dict

    # ----------------
    # helper functions
    # ----------------

    def get_wallpapers(self, colorscheme: str) -> list | None:
        return self.wallpaper_dict.get(colorscheme, None)

    # --------------------------------
    # functions for applying wallpaper
    # --------------------------------
    def choose_random_wallpaper(self, colorscheme) -> str:
        wallpaper_list = self.get_wallpapers(colorscheme)

        if wallpaper_list == None:
            sys.exit(
                f"Wallpaper list for the colorscheme - {colorscheme} is not found!\n"
            )

        return wallpaper_list[random.randint(0, len(wallpaper_list) - 1)]

    def choose_wallpaper(self) -> str:
        menu_entries = "\n".join(
            [
                f"{colorscheme}:\n"
                + "\n".join([f"  {wallpaper}" for wallpaper in wallpaper_list])
                for colorscheme, wallpaper_list in self.wallpaper_dict.items()
            ]
        )
        colorscheme_names = self.wallpaper_dict.keys()
        prompt_name = "Wallpapers: "

        selected_wallpaper = self.menu.get_selection(menu_entries, prompt_name)

        if selected_wallpaper in colorscheme_names:
            sys.exit(
                f"'{selected_wallpaper}' is not a wallpaper but a colorscheme name!\n"
            )

        return selected_wallpaper

    # ------------------------------------------------
    # functions for choosing and applying colorschemes
    # ------------------------------------------------
    def choose_colorscheme(self) -> str:
        menu_entries = "\n".join(self.colorscheme_dict.values())
        prompt_name = "Colorscheme: "

        selected_entry = self.menu.get_selection(menu_entries, prompt_name)

        # selected colorscheme
        colorscheme = next(
            (
                key
                for key, value in self.colorscheme_dict.items()
                if value == selected_entry
            ),
            "",
        )

        return colorscheme

    def apply_colorscheme(
        self,
        colorscheme: str,
        manage_programs: dict[str, ProgramColor],
        allowed_programs: dict = {},
    ) -> None:
        # set colorscheme for all selected programs
        if colorscheme in allowed_programs:
            program_list = allowed_programs[colorscheme]

            for program_obj in program_list:
                if program_obj in manage_programs.keys():
                    manage_programs[program_obj].apply(colorscheme)
        else:
            for program_obj in manage_programs.values():
                program_obj.apply(colorscheme)

    def apply_wallpaper(
        self,
        colorscheme: str,
        choose_wallpaper: bool = False,
        apply_wallpaper_functions: list[Callable] = [],
    ) -> tuple[str, str | None]:
        scheme = None

        if colorscheme == "matugen":
            schemes = [
                "Tonal-spot",
                "Neutral",
                "Fidelity",
                "Content",
                "Rainbow",
                "Monochrome",
                "Expressive",
                "Fruit-salad",
            ]

            entries = "\n".join(schemes)
            scheme = self.menu.get_selection(
                entries,
                prompt_name="Color Generation Scheme: ",
            )
            scheme = f"scheme-{scheme.lower()}"

        # choose a wallpaper
        if choose_wallpaper:
            selection = self.menu.get_confirmation(
                question="Choose a wallpaper? ",
                positive=" Yes",
                negative=" No (random wallpaper choosen)",
            )

            if selection:
                wallpaper = self.choose_wallpaper()
            else:
                wallpaper = self.choose_random_wallpaper(colorscheme)
        else:
            wallpaper = self.choose_random_wallpaper(colorscheme)

        # apply the wallpaper
        for func in apply_wallpaper_functions:
            func(wallpaper)

        if colorscheme == "matugen":
            return wallpaper, scheme
        else:
            return wallpaper, scheme

    def _apply(
        self,
        matugen_gen_color: Callable,
        manage_programs: dict[str, ProgramColor],
        reload_programs: dict[Callable, dict[str, list]],
        choose_wallpaper: bool = False,
        apply_wallpaper_functions: list = [Callable],
        allowed_programs: dict = {},
    ) -> None:
        colorscheme = self.choose_colorscheme()

        if not colorscheme:
            sys.exit()
        elif colorscheme.startswith("[") and colorscheme.endswith("]"):
            sys.exit(f"'cancel' was chosen when prompted for choosing a colorscheme.\n")

        wallpaper, matugen_scheme = self.apply_wallpaper(
            colorscheme,
            choose_wallpaper,
            apply_wallpaper_functions,
        )

        # generate matugen colorscheme
        if colorscheme == "matugen":
            matugen_gen_color(wallpaper, matugen_scheme)

        self.apply_colorscheme(colorscheme, manage_programs, allowed_programs)

        # repload programs
        for func, args in reload_programs.items():
            params = []

            if "replace" in args:
                if "colorscheme" in args["replace"]:
                    params.append(colorscheme)

            if "params" in args:
                for param in args["params"]:
                    params.append(param)

            func(*params)
