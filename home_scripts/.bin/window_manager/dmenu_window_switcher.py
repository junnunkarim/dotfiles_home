#!/usr/bin/env python

import sys
import argparse
import subprocess
import os

from helper.class_dmenu import Dmenu
from helper.functions import fail_exit


def get_window_list():
    command = ["wmctrl", "-l"]

    output = subprocess.run(command, capture_output=True)

    if output.returncode != 0:
        fail_exit(
            exit_code=output.returncode,
            stderr=output.stderr,
            error="Couldn't get window list using 'wmctrl'!",
        )

    username = os.getlogin()
    window_list = []

    for line in output.stdout.decode().strip().split("\n"):
        username_index = line.find(username)

        if username_index != -1:
            start_index = username_index + len(username)
            substring_after_username = line[start_index:].strip()
            window_list.append(substring_after_username)

    return window_list


def switch_window(window: str) -> bool:
    command = ["wmctrl", "-a", window]

    output = subprocess.run(command, start_new_session=True)

    if output.returncode != 0:
        return False

    return True


# --------------
# main functions
# --------------
def window_switcher(menu: str, wm: str | None = None) -> None:
    if menu == "dmenu":
        menu_obj = Dmenu(
            width=800,
            line=8,
        )
    else:
        fail_exit(error=f"Menu - '{menu}' is not recognized!")
        return  # for supressing warnings

    window_list = get_window_list()

    entries = "\n".join(window_list)

    window = menu_obj.get_selection(
        prompt_name="Window Switcher:",
        entries=entries,
    )

    status = switch_window(window)

    if not status:
        fail_exit(
            error="Couldn't switch focus to selected window using 'wmctrl'!",
        )


def main() -> None:
    wms = ["dwm"]
    menus = ["dmenu"]

    arg_parser = argparse.ArgumentParser(description="open app launcher")
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
        # required=True,
    )

    # if no cli arguments are provided, show the help message and exit
    if len(sys.argv) <= 1:
        arg_parser.print_help()
        fail_exit()

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.window_manager:
        window_switcher(menu=args.menu, wm=args.window_manager)
    elif args.menu:
        window_switcher(menu=args.menu)
    else:
        arg_parser.print_help()
        fail_exit()


if __name__ == "__main__":
    main()
