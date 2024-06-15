#!/usr/bin/env python

import sys
import subprocess
import argparse
import re

from pathlib import Path as path


# ----------------
# helper functions
# ----------------
def get_screen_resolution():
    command = ["xrandr"]
    output = subprocess.check_output(command).decode()

    for line in output.splitlines():
        if "current" in line:
            resolution = line.split("current ")[1].split(",")[0].strip().split(" x ")
            break
    else:
        resolution = None

    return resolution


def parse_keybindings(wm: str, file_path: path | None = None) -> dict:
    if not file_path:
        if wm == "dwm":
            file_path = path("~/.config/dwm/src/config.h").expanduser()
        # elif wm == "qtile":
        #     file_path = f"{path('~/.config/dwm/src/config.h').expanduser()}"
        else:
            file_path = path("~/.config/dwm/src/config.h").expanduser()

    keybindings = {}

    if file_path.is_file():
        # Regular expression to match the desired comment pattern
        if wm == "dwm":
            pattern = re.compile(r"//desc:\s*(.+?)\s*\|\s*(.+)")
        elif wm == "qtile":
            pattern = re.compile(r"#desc:\s*(.+?)\s*\|\s*(.+)")
        else:
            pattern = re.compile(r"//desc:\s*(.+?)\s*\|\s*(.+)")

        with open(file_path, "r") as file:
            for line in file:
                match = pattern.search(line)
                if match:
                    key_combination = match.group(1).strip()
                    description = match.group(2).strip()
                    keybindings[key_combination] = description

    return keybindings


def keybindings_to_string(keybindings, max_length=200):
    result = []

    for key, value in keybindings.items():
        # calculate available space for the description
        space_available = max_length - len(key) - 1

        if len(value) > space_available:
            value = value[: space_available - 3] + "..."  # truncate value if necessary

        # format each line
        formatted_line = f"{key.ljust(max_length - len(value) - 1)}{value}"
        result.append(formatted_line)

    return "\n".join(result) + "\n"


# -------------------------------
# functions creating menu prompts
# -------------------------------
def dmenu_prompt(width: int = 1000) -> list:
    screen_res = get_screen_resolution()

    if screen_res:
        # calculate screen dimensions to
        # display the menu at the center of the screen
        res_x, res_y = int(screen_res[0]), int(screen_res[1])

        height = 45 * 10
        # 'x' is the x-position of the window's upper left corner
        # 'y' is the y-position of the window's upper left corner
        x = (res_x // 2) - (width // 2)
        y = (res_y // 2) - (height // 2)

        # main prompt
        prompt = [
            "dmenu",
            "-h",
            "45",
            "-l",
            "10",
            "-W",
            f"{width}",
            "-X",
            f"{x}",
            "-Y",
            f"{y}",
        ]
    else:
        # if can't get screen resolution,
        # use the default prompt
        prompt = ["dmenu", "-h", "45", "-l", "12"]

    return prompt


def rofi_prompt(wm: None | str) -> list:
    # if 'wm' is not given, the if statment will be false
    script_path = path(
        f"~/.config/{wm}/external_configs/rofi/script_menu_1.rasi"
    ).expanduser()

    if script_path.is_file():
        # if config is found at specific directory, use it
        prompt = [
            "rofi",
            "-dmenu",
            "-theme",
            f"{script_path}",
        ]
    else:
        # if window-manager name is not given,
        # use default 'rofi' theme
        prompt = [
            "rofi",
            "-dmenu",
        ]

    return prompt


# --------------
# main functions
# --------------
def keybindings(menu: str, wm: str, file_path: path | None = None) -> bool:
    keybindings = parse_keybindings(wm, file_path)

    if not keybindings:
        return False

    keybindigs_str = keybindings_to_string(keybindings, max_length=85)

    # currently only specifically patched 'dmenu' works
    if menu == "dmenu":
        prompt = dmenu_prompt(950)
        # extra things to add to the prompt
        prompt_extra = ["-p", "Keybindings:"]
    elif menu == "rofi":
        prompt = rofi_prompt(wm)
        # extra things to add to the prompt
        prompt_extra = ["-p", "Keybindings"]
    else:
        return False

    subprocess.run(prompt + prompt_extra, input=keybindigs_str, text=True)

    return True


def main() -> None:
    wms = ["dwm", "qtile"]
    menus = ["dmenu", "rofi"]

    arg_parser = argparse.ArgumentParser(description="show all keybindings")
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
    if len(sys.argv) <= 1:
        arg_parser.print_help()
        sys.exit(1)

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.window_manager and args.file_path:
        status_success = keybindings(
            menu=args.menu,
            wm=args.window_manager,
            file_path=path(args.key_file).expanduser(),
        )
    elif args.menu and args.window_manager:
        status_success = keybindings(menu=args.menu, wm=args.window_manager)
    else:
        arg_parser.print_help()
        sys.exit(1)

    if not status_success:
        print("Error!")
        sys.exit(1)
    else:
        sys.exit()


if __name__ == "__main__":
    main()
