#!/usr/bin/env python

import os
import sys
import argparse

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))


from class__main.menus.dmenu import Dmenu
from class__main.menus.fuzzel import Fuzzel

from class__main.client_manager.hyprland import HyprClientManager


def client_manager(menu: str, wm: str, only_minimize: bool) -> None:
    if menu == "dmenu":
        menu_obj = Dmenu(
            width=1400,
            line=15,
            fuzzy=False,
        )
    elif menu == "fuzzel":
        menu_obj = Fuzzel(
            width=100,
            line=12,
        )
    else:
        sys.exit(f"Menu - '{menu}' is not recognized!")

    if wm == "hyprland":
        client_manager = HyprClientManager(menu_obj, only_minimize=only_minimize)
    else:
        sys.exit(f"Window Manager - '{wm}' is not recognized!")

    client_manager.run()


def main() -> None:
    menus = ["dmenu", "fuzzel"]
    wms = ["dwm", "hyprland"]
    only_minimize = False

    arg_parser = argparse.ArgumentParser(description="client window manager")
    # define necessary cli arguments
    arg_parser.add_argument(
        "-m",
        "--menu",
        help="specify the menu launcher",
        choices=menus,
        required=True,
    )
    arg_parser.add_argument(
        "-w",
        "--window-manager",
        help="specify the window manager",
        choices=wms,
        required=True,
    )
    arg_parser.add_argument(
        "--only_minimize",
        help="only handle client minimizing",
        action="store_true",
    )

    # if no cli arguments are provided, show the help message and exit
    if len(sys.argv) <= 1:
        arg_parser.print_help()
        sys.exit()

    # parse all cli arguments
    args = arg_parser.parse_args()

    if args.only_minimize:
        only_minimize = True

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.window_manager:
        client_manager(
            menu=args.menu,
            wm=args.window_manager,
            only_minimize=only_minimize,
        )
    else:
        arg_parser.print_help()
        sys.exit()


if __name__ == "__main__":
    main()
