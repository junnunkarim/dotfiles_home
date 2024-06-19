from subprocess import run, Popen
from fileinput import FileInput
from pathlib import Path
from getpass import getuser
from random import choice as random_choice

from .class_menu import Menu
from .functions import fail_exit, safe_exit


class Window_manager:
    _menu: Menu
    _username = getuser()
    _programs_to_manage = []
    # key is the colorscheme name and value is the wallpaper filename list
    _wallpaper_dict = {}
    # key is the colorscheme name and value is the string format to show to user
    _colorscheme_dict = {}

    def __init__(
        self,
        menu: Menu,
        programs_to_manage: list | dict,
        wallpaper_dict: dict,
        colorscheme_dict: dict,
    ) -> None:
        self._menu = menu

        if not programs_to_manage:
            fail_exit(
                error=f"'programs_to_manage' is of type {type(programs_to_manage)}.\nIt can only be of type list or dictionary!"
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
    def replace_string(
        self,
        replace: str,
        start_concatenate: str,
        end_concatenate: str,
        file_path: Path,
    ) -> None:
        file_path = Path(file_path).expanduser()

        with FileInput(file_path, inplace=True) as file_content:
            for line in file_content:
                if line.startswith(start_concatenate):
                    # replace the string within quotes
                    line = start_concatenate + replace + end_concatenate + "\n"
                print(line, end="")

    def _get_wallpapers(self, colorscheme: str) -> list | None:
        return self._wallpaper_dict.get(colorscheme, None)

    # ---------------------------------------------------------------
    # functions for changing gui/cli application colorschemes/themes
    # ---------------------------------------------------------------

    # programs with universally defined location
    # ------------------------------------------
    def change_alacritty_color(
        self,
        colorscheme: str,
        file_path: Path = Path("~/.config/alacritty/colors.toml").expanduser(),
    ) -> None:
        start_concatenate = 'import = ["~/.config/alacritty/colorschemes/'
        end_concatenate = '.toml"]'

        self.replace_string(colorscheme, start_concatenate, end_concatenate, file_path)

    def change_btop_color(
        self,
        colorscheme: str,
        file_path: Path = Path("~/.config/btop/btop.conf").expanduser(),
    ) -> None:
        start_concatenate = 'color_theme = "'
        end_concatenate = '"'

        self.replace_string(colorscheme, start_concatenate, end_concatenate, file_path)

    def change_gtk_color(
        self,
        colorscheme: str,
        file_path: Path = Path("~/.config/gtk-3.0/settings.ini").expanduser(),
    ) -> None:
        start_concatenate = "gtk-theme-name="
        end_concatenate = ""

        self.replace_string(colorscheme, start_concatenate, end_concatenate, file_path)

    def change_helix_color(
        self,
        colorscheme: str,
        file_path: Path = Path("~/.config/helix/config.toml").expanduser(),
    ) -> None:
        start_concatenate = 'theme = "'
        end_concatenate = '"'

        self.replace_string(colorscheme, start_concatenate, end_concatenate, file_path)

    def change_kitty_color(
        self,
        colorscheme: str,
        file_path: Path = Path("~/.config/kitty/kitty.conf").expanduser(),
    ) -> None:
        start_concatenate = "include ~/.config/kitty/colorschemes/"
        end_concatenate = ".conf"

        self.replace_string(colorscheme, start_concatenate, end_concatenate, file_path)

    def change_konsole_color(
        self,
        colorscheme: str,
        file_path: Path = Path("~/.local/share/konsole/main.profile").expanduser(),
    ) -> None:
        start_concatenate = "ColorScheme="
        end_concatenate = ""

        self.replace_string(colorscheme, start_concatenate, end_concatenate, file_path)

    def change_zathura_color(
        self,
        colorscheme: str,
        file_path: Path = Path("~/.config/zathura/zathurarc").expanduser(),
    ) -> None:
        start_concatenate = "include colorschemes/"
        end_concatenate = ""

        self.replace_string(colorscheme, start_concatenate, end_concatenate, file_path)

    # programs with user defined location
    # -----------------------------------
    def change_nvim_color(
        self,
        colorscheme: str,
        file_path: Path = Path("~/.config/nvim/lua/core/colorscheme.lua").expanduser(),
    ) -> None:
        start_concatenate = 'local color = "'
        end_concatenate = '"'

        self.replace_string(colorscheme, start_concatenate, end_concatenate, file_path)

    # ------------------------------------
    # functions for hot reloading programs
    # ------------------------------------
    def reload_kitty(self) -> int:
        command = ["pkill", "-SIGUSR1", "-x", "kitty"]

        output = Popen(command, start_new_session=True)

        return output.returncode

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
        output = run(command, text=True, check=True)

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
        prompt_name = "Wallpapers:"

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
        prompt_name = "Colorscheme:"

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

    def _apply_colorscheme(
        self, colorscheme: str, program: str, file_path: Path | None = None
    ) -> None:
        fn_change_program_color = getattr(self, "change_" + program + "_color", None)

        if not fn_change_program_color:
            fail_exit(
                error=f"Could not find the function named 'change_{program}_color'!"
            )
            return  # to supress the warning

        print()
        print(f"program: {program}")
        print(f"function name: {fn_change_program_color}")
        print()

        if program == "nvim" and colorscheme == "matugen":
            return
        elif program == "nvim":
            if colorscheme == "catppuccin_macchiato":
                colorscheme = "base16-catppuccin-macchiato"
            elif colorscheme == "dracula":
                colorscheme = "base16-dracula"
            elif colorscheme == "everblush":
                colorscheme = "everblush"
            elif colorscheme == "everforest":
                colorscheme = "base16-everforest"
            elif colorscheme == "gruvbox":
                colorscheme = "base16-gruvbox-dark-medium"
            elif colorscheme == "nord":
                colorscheme = "base16-nord"
            elif colorscheme == "rose_pine":
                colorscheme = "base16-rose-pine"
            else:
                fail_exit(
                    error=f"Configuration for colorscheme '{colorscheme}' is not found!"
                )

        if file_path == None:
            fn_change_program_color(colorscheme)
        else:
            fn_change_program_color(colorscheme, file_path)

            # globals()["change_" + program + "_color"](colorscheme)

    def _apply(self, colorscheme: str) -> None:
        if colorscheme == "cancel":
            safe_exit(
                message="'cancel' was chosen when prompted for choosing a colorscheme."
            )
        allowed_programs_for_matugen = ["dwm", "dmenu", "luastatus", "kitty"]

        if type(self._programs_to_manage) == list:
            for program in self._programs_to_manage:
                if colorscheme == "matugen":
                    if program in allowed_programs_for_matugen:
                        self._apply_colorscheme(colorscheme, program)
                else:
                    self._apply_colorscheme(colorscheme, program)
        elif type(self._programs_to_manage) == dict:
            for program, file_path in self._programs_to_manage:
                if colorscheme == "matugen":
                    if program in allowed_programs_for_matugen:
                        self._apply_colorscheme(colorscheme, program, Path(file_path))
                else:
                    self._apply_colorscheme(colorscheme, program, Path(file_path))
