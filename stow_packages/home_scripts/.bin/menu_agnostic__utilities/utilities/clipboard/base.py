#!/usr/bin/env python

import os
import sys

from sys import argv
from argparse import ArgumentParser

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))

from class__main.clipboard.x11 import ClipboardX11
from class__main.clipboard.wayland import ClipboardWayland


# --------------
# main functions
# --------------
def clipboard(menu: str, display_server: bool) -> None:
    if display_server == "x11":
        clipboard_obj = ClipboardX11(menu, prompt_name="Clipboard: ")
    else:
        clipboard_obj = ClipboardWayland(menu, prompt_name="Clipboard: ")

    clipboard_obj.run()


def main() -> None:
    menus = ["dmenu", "fuzzel", "rofi"]
    display_server = ["x11", "wayland"]

    arg_parser = ArgumentParser(description="open clipboard")
    # define necessary cli arguments
    arg_parser.add_argument(
        "-m",
        "--menu",
        help="specify the menu launcher",
        choices=menus,
        required=True,
    )
    arg_parser.add_argument(
        "-d",
        "--display_server",
        help="specify the display server",
        choices=display_server,
        required=True,
    )

    # if no cli arguments are provided, show the help message and exit
    if len(argv) <= 1:
        arg_parser.print_help()
        sys.exit()

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.display_server:
        clipboard(menu=args.menu, display_server=args.display_server)
    else:
        arg_parser.print_help()
        sys.exit()


if __name__ == "__main__":
    main()
