from subprocess import run, Popen, check_output
from pathlib import Path
from getpass import getuser
from random import choice as random_choice

from .class_menu import Menu
from .class_program_color import Program_color
from .functions import fail_exit, safe_exit

import time


class Window_manager:
    _menu: Menu
    _username = getuser()
    _programs_to_manage: dict[str, Program_color]
    # key is the colorscheme name and value is the wallpaper filename list
    _wallpaper_dict: dict
    # key is the colorscheme name and value is the string format to show to user
    _colorscheme_dict: dict

    def __init__(
        self,
        menu: Menu,
        programs_to_manage: dict[str, Program_color],
        wallpaper_dict: dict,
        colorscheme_dict: dict,
    ) -> None:
        self._menu = menu

        if not programs_to_manage:
            fail_exit(
                error=f"'programs_to_manage' is of type {type(programs_to_manage)}.\nIt can only be a list of 'Program_color' objects!"
            )
        self._programs_to_manage = programs_to_manage
        # print("programs_to_manage:")
        # print(self._programs_to_manage)

        if not wallpaper_dict:
            fail_exit(
                error=f"'wallpaper_dict' is of type {type(wallpaper_dict)}.\nIt can only be of type dictionary!"
            )
        self._wallpaper_dict = wallpaper_dict
        # print("wallpaper_dict:")
        # print(self._wallpaper_dict)

        if not colorscheme_dict:
            fail_exit(
                error=f"'colorscheme_dict' is of type {type(colorscheme_dict)}.\nIt can only be of type dictionary!"
            )
        self._colorscheme_dict = colorscheme_dict
        # print("colorscheme_dict:")
        # print(self._colorscheme_dict)

    # ----------------
    # helper functions
    # ----------------

    # core string replacement function
    # --------------------------------
    def _get_wallpapers(self, colorscheme: str) -> list | None:
        return self._wallpaper_dict.get(colorscheme, None)

    # ------------------------------------
    # functions for hot reloading programs
    # ------------------------------------
    def reload_kitty(self):
        command = ["pkill", "-SIGUSR1", "-x", "kitty"]

        Popen(command, start_new_session=True)

    def reload_konsole(
        self,
        change_colors_to: str,
        main_profile: str,
        dummy_profile: str = "dummy",
        delay: float = 0.05,
    ):
        # get all konsole instances
        konsole_instances = check_output(["qdbus"], text=True).splitlines()
        konsole_instances = [i for i in konsole_instances if "org.kde.konsole" in i]

        # `dummy` must be at the start
        profiles = [dummy_profile, main_profile]

        for instance in konsole_instances:
            # aet all sessions for the instance
            sessions = check_output(
                ["qdbus", f"{instance.strip()}"], text=True
            ).splitlines()
            sessions = [s for s in sessions if s.startswith("/Sessions/")]

            for session in sessions:
                for profile in profiles:
                    command_1 = [
                        "qdbus",
                        f"{instance.strip()}",
                        f"{session.strip()}",
                        "org.kde.konsole.Session.setProfile",
                        f"{profile}",
                    ]
                    run(command_1, start_new_session=True, check=True)

                    time.sleep(delay)

                # inserts the cammond into all open konsole clients
                # creates issues
                # set_colors = [
                #     "qdbus",
                #     f"{instance.strip()}",
                #     f"{session.strip()}",
                #     "org.kde.konsole.Session.runCommand",
                #     f"konsoleprofile colors={change_colors_to}",
                # ]
                # run(set_colors, start_new_session=True, check=True)
                #
                # time.sleep(delay)

        # print(f"Successfully applied color profiles: {colors}")

    # ------------------------------
    # functions for color generation
    # ------------------------------
    def matugen_generate(self, wallpaper: str) -> int:
        wallpaper_path = Path("~/.config/wallpaper/" + wallpaper).expanduser()

        command = [
            "matugen",
            "image",
            "-j",
            "hex",
            # "-t",
            # "scheme-fruit-salad",
            # "scheme-neutral",
            # "scheme-fidelity",
            # "scheme-content",
            # "scheme-rainbow",
            # "scheme-monochrome",
            # "scheme-expressive",
            wallpaper_path,
        ]

        # run the command
        output = run(command, start_new_session=True, text=True, check=True)

        return output.returncode

    # --------------------------------
    # functions for applying wallpaper
    # --------------------------------
    def _choose_random_wallpaper(self, colorscheme) -> str:
        wallpaper_list = self._get_wallpapers(colorscheme)

        if wallpaper_list == None:
            fail_exit(
                error=f"Wallpaper list for the colorscheme - {colorscheme} is not found!"
            )
            return ""  # to supress the warning

        return random_choice(wallpaper_list)

    def _choose_wallpaper(self) -> str:
        menu_entries = "\n".join(
            [
                f"{colorscheme}:\n"
                + "\n".join([f"  {wallpaper}" for wallpaper in wallpaper_list])
                for colorscheme, wallpaper_list in self._wallpaper_dict.items()
            ]
        )
        colorscheme_names = self._wallpaper_dict.keys()
        prompt_name = "Wallpapers: "

        selected_wallpaper = self._menu.get_selection(menu_entries, prompt_name)

        if selected_wallpaper in colorscheme_names:
            fail_exit(
                error=f"'{selected_wallpaper}' is not a wallpaper but a colorscheme name!"
            )

        return selected_wallpaper

    # ------------------------------------------------
    # functions for choosing and applying colorschemes
    # ------------------------------------------------
    def _choose_colorscheme(self) -> str:
        menu_entries = "\n".join(self._colorscheme_dict.values())
        prompt_name = "Colorscheme: "

        selected_entry = self._menu.get_selection(menu_entries, prompt_name)

        # selected colorscheme
        colorscheme = next(
            (
                key
                for key, value in self._colorscheme_dict.items()
                if value == selected_entry
            ),
            "",
        )

        return colorscheme

    def _apply(self, colorscheme: str, allowed_programs: dict = {}) -> None:
        if colorscheme == "cancel":
            safe_exit(
                message="'cancel' was chosen when prompted for choosing a colorscheme."
            )

        if colorscheme in allowed_programs:
            program_list = allowed_programs[colorscheme]

            for program in program_list:
                if program in self._programs_to_manage.keys():
                    # print(f"{program}: {self._programs_to_manage[program]}")
                    self._programs_to_manage[program].apply(colorscheme)
        else:
            for program_obj in self._programs_to_manage.values():
                program_obj.apply(colorscheme)
