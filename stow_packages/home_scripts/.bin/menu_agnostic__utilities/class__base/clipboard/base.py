import os
import sys

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from class__base.menu.base import Menu

from class__main.menus.dmenu import Dmenu
from class__main.menus.fuzzel import Fuzzel
from class__main.menus.rofi import Rofi


class Clipboard:
    menu_obj: Menu
    prompt_name: str

    def __init__(self, menu: str, prompt_name: str) -> None:
        if menu == "dmenu":
            menu_obj = Dmenu(
                width=950,
                line=12,
            )
        elif menu == "fuzzel":
            menu_obj = Fuzzel(
                width=80,
                line=12,
            )
        elif menu == "rofi":
            menu_obj = Rofi(
                line=16,
            )
        else:
            sys.exit(f"Menu - '{menu}' is not recognized!\n")

        self.menu_obj = menu_obj
        self.prompt_name = prompt_name

    def run(self) -> None:
        pass
