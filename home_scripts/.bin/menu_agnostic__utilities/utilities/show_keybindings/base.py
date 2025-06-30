#!/usr/bin/env python

import os
import sys

from sys import argv
from argparse import ArgumentParser
from pathlib import Path
from re import compile as re_compile

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))

from class__main.menus.dmenu import Dmenu
from class__main.menus.fuzzel import Fuzzel


# ----------------
# helper functions
# ----------------
def keybindings_to_string(key: str, description: str, max_length: int) -> str:
    # calculate available space for the description
    space_available = max_length - len(key) - 1

    if len(description) > space_available:
        description = (
            description[: space_available - 3] + "..."
        )  # truncate value if necessary

    # return formatted line
    return f"{key.ljust(max_length - len(description) - 1)}{description}"


def parse_keybindings(
    wm: str, file_path: Path | None = None, max_length: int = 200
) -> list[str]:
    if not file_path:
        if wm == "dwm":
            file_path = Path("~/.config/dwm/src/config.h").expanduser()
        elif wm == "hyprland":
            file_path = Path("~/.config/hypr/defaults/keybindings.conf").expanduser()
        else:
            sys.exit(f"{wm} config file with keybindings not found!\n")

    if not file_path.is_file():
        sys.exit(f"{wm} config file with keybindings not found!\n")

    # Regular expression to match the desired comment pattern
    if wm == "dwm":
        pattern = re_compile(r"//desc:\s*(.+?)\s*\|\s*(.+)")
    elif wm == "qtile" or wm == "hyprland":
        pattern = re_compile(r"#desc:\s*(.+?)\s*\|\s*(.+)")
    else:
        sys.exit(f"Window manager - {wm} is not supported!\n")

    keybindings = []

    with open(file_path, "r") as file:
        for line in file:
            match = pattern.search(line)

            if match:
                key_combination = match.group(1).strip()
                description = match.group(2).strip()

                keybindings.append(
                    keybindings_to_string(key_combination, description, max_length)
                )

    return keybindings


# --------------
# main functions
# --------------
def keybindings(menu: str, wm: str, file_path: Path | None = None) -> None:
    str_width = 85
    keybindings = parse_keybindings(wm, file_path, str_width)

    if not keybindings:
        sys.exit(f"Keybindings for {wm} is empty!\n")

    keybindings = "\n".join(keybindings)

    if menu == "dmenu":
        menu_obj = Dmenu(
            width=950,
            line=12,
        )
    elif menu == "fuzzel":
        menu_obj = Fuzzel(
            width=80,
            line=16,
        )
    else:
        sys.exit(f"Menu - '{menu}' is not recognized!\n")

    menu_obj.show(
        entries=keybindings,
        prompt_name="Keybindings: ",
    )


def main() -> None:
    wms = ["dwm", "hyprland"]
    menus = ["dmenu", "fuzzel"]

    arg_parser = ArgumentParser(description="show all keybindings")
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
        "-fp",
        "--file-path",
        help="specify the file containing keybindings with comments",
        # required=True,
    )

    # if no cli arguments are provided, show the help message and exit
    if len(argv) <= 1:
        arg_parser.print_help()
        sys.exit()

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.window_manager and args.file_path:
        keybindings(
            menu=args.menu,
            wm=args.window_manager,
            file_path=Path(args.key_file).expanduser(),
        )
    elif args.menu and args.window_manager:
        keybindings(menu=args.menu, wm=args.window_manager)
    else:
        arg_parser.print_help()
        sys.exit()


if __name__ == "__main__":
    main()
