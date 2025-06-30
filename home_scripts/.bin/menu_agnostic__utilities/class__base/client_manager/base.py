import os
import sys

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from menu.base import Menu


class ClientManager:
    menu: Menu

    def __init__(
        self,
        menu: Menu,
    ) -> None:
        self.menu = menu

    def run(self):
        pass
