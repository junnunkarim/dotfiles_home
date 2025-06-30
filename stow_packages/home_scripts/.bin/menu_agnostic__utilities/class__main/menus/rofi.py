import sys
import os

from pathlib import Path

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from class__base.menu.base import Menu


class Rofi(Menu):
    def __init__(
        self,
        main_prompt=["rofi", "-dmenu"],
        # width: int = 80,
        # height: int = 45,
        line: int = 15,
        # fuzzy: bool = True,
        # case_insensitive: bool = True,
        # original_dmenu: bool = False,
    ) -> None:
        main_prompt += [
            "-l",
            f"{line}",
            "-config",
            Path("~/.config/rofi/script_menu_1.rasi").expanduser(),
        ]

        super().__init__(main_prompt)
