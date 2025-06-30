#!/usr/bin/env python

import sys
import os

from sys import argv
from argparse import ArgumentParser
from subprocess import run

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))

from class__main.menus.dmenu import Dmenu
from class__main.menus.fuzzel import Fuzzel


# ----------------
# helper functions
# ----------------
def get_uptime() -> str:
    output = run(
        ["uptime", "-p"],
        text=True,
        capture_output=True,
    ).stdout.strip()

    return (
        output.replace("up ", "")
        .replace("hours", "h")
        .replace("hour", "h")
        .replace("minutes", "m")
        .replace("minute", "m")
    )


def get_hostname() -> str:
    return run(
        ["cat", "/proc/sys/kernel/hostname"],
        text=True,
        capture_output=True,
    ).stdout.strip()


def logout(wm: str) -> None:
    if wm == "awesome":
        run(
            ["awesome-client", "'awesome.quit()'"],
            text=True,
        )
    elif wm == "dwm":
        run(
            ["pkill", "-TERM", "-x", "dwm"],
            text=True,
        )
    elif wm == "hyprland":
        run(
            ["hyprctl", "dispatch", "exit"],
            text=True,
        )
    elif wm == "i3":
        run(
            ["i3-msg", "exit"],
            text=True,
        )
    elif wm == "openbox":
        run(
            ["openbox", "--exit"],
            text=True,
        )
    elif wm == "qtile":
        run(
            ["qtile", "cmd-obj", "-o", "cmd", "-f", "shutdown"],
            text=True,
        )
    else:
        sys.exit(f"Window manager - '{wm}' is not recognized!\n")


# --------------
# main functions
# --------------
def powermenu(menu: str, wm: str | None = None) -> None:
    uptime = f"{get_uptime()}:"
    host = get_hostname()
    entries = {
        "[cancel]": "[  Cancel ]",
        "hibernate": " Hibernate",
        "shutdown": " Shutdown",
        "reboot": "󰜉 Reboot",
        "suspend": "󰒲 Suspend",
        "lock": " Lock",
    }

    # if 'wm' is given show logout option
    if wm:
        entries["logout"] = "󰗽 Logout"

    if menu == "dmenu":
        menu_obj = Dmenu(
            width=500,
            line=len(entries),
        )
    elif menu == "fuzzel":
        menu_obj = Fuzzel(
            width=38,
            line=7,
        )
    else:
        sys.exit(f"Menu - '{menu}' is not recognized!\n")

    # encode every entry in the dictionary with as a
    # string with newline at the end of each entry
    options = "\n".join(entries.values())

    selection = menu_obj.get_selection(
        entries=options,
        prompt_name="(" + host + ") " + uptime + " ",
    )

    # selected option
    choice = next((key for key, value in entries.items() if value == selection), "")

    if choice.startswith("[") and choice.endswith("]"):
        sys.exit(f"'cancel' was chosen when prompted for choosing an option.\n")

    if not menu_obj.get_confirmation():
        sys.exit(f"Canceled Operation.\n")

    # if run by giving window-manager flag
    if wm and choice == "logout":
        logout(wm)
    else:
        command = []

        if choice == "hibernate":
            command = ["systemctl", "hibernate"]
        elif choice == "shutdown":
            command = ["systemctl", "poweroff"]
        elif choice == "reboot":
            command = ["systemctl", "reboot"]
        elif choice == "suspend":
            command = ["systemctl", "suspend"]
        elif choice == "lock":
            if wm == "hyprland":
                command = ["hyprlock"]
            else:
                command = ["betterlockscreen", "-l"]

        if command:
            run(command, text=True)


def main() -> None:
    wms = ["dwm", "hyprland"]
    menus = ["dmenu", "fuzzel"]

    arg_parser = ArgumentParser(description="open powermenu")

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
    )

    # if no cli arguments are provided, show the help message and exit
    if len(argv) <= 1:
        arg_parser.print_help()
        sys.exit()

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.window_manager:
        powermenu(menu=args.menu, wm=args.window_manager)
    elif args.menu:
        powermenu(menu=args.menu)
    else:
        arg_parser.print_help()
        sys.exit()


if __name__ == "__main__":
    main()
