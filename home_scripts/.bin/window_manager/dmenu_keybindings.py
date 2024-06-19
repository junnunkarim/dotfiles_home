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
    wm: str, file_path: path | None = None, max_length: int = 200
) -> list[str]:
    if not file_path:
        if wm == "dwm":
            file_path = path("~/.config/dwm/src/config.h").expanduser()
        # elif wm == "qtile":
        #     file_path = f"{path('~/.config/dwm/src/config.h').expanduser()}"
        else:
            file_path = path("~/.config/dwm/src/config.h").expanduser()

    if not file_path.is_file():
        return []

    # Regular expression to match the desired comment pattern
    if wm == "dwm":
        pattern = re.compile(r"//desc:\s*(.+?)\s*\|\s*(.+)")
    elif wm == "qtile":
        pattern = re.compile(r"#desc:\s*(.+?)\s*\|\s*(.+)")
    else:
        return []

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


# -------------------------------
# functions creating menu prompts
# -------------------------------
def dmenu_prompt(width: int = 1000) -> list:
    screen_res = get_screen_resolution()

    if not screen_res:
        # if can't get screen resolution,
        # use the default prompt
        return ["dmenu", "-l", "12"]

    # calculate screen dimensions to
    # display the menu at the center of the screen
    res_x, res_y = int(screen_res[0]), int(screen_res[1])

    height = 45 * 10
    # 'x' is the x-position of the window's upper left corner
    # 'y' is the y-position of the window's upper left corner
    x = (res_x // 2) - (width // 2)
    y = (res_y // 2) - (height // 2)

    # main prompt
    return [
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


def rofi_prompt(wm: None | str) -> list:
    # if 'wm' is not given, the if statment will be false
    script_path = path(
        f"~/.config/{wm}/external_configs/rofi/script_menu_1.rasi"
    ).expanduser()

    if not script_path.is_file():
        # if window-manager name is not given,
        # use default 'rofi' theme
        return ["rofi", "-dmenu"]

    # if config is found at specific directory, use it
    return ["rofi", "-dmenu", "-theme", f"{script_path}"]


# --------------
# main functions
# --------------
def keybindings(menu: str, wm: str, file_path: path | None = None) -> bool:
    str_width = 85
    keybindings = parse_keybindings(wm, file_path, str_width)

    if not keybindings:
        return False

    keybindings = "\n".join(keybindings) + "\n"

    # currently only specifically patched 'dmenu' works
    if menu == "dmenu":
        dmenu_width = 950
        prompt = dmenu_prompt(dmenu_width)
        # extra things to add to the prompt
        prompt_extra = ["-p", "Keybindings:"]
    elif menu == "rofi":
        prompt = rofi_prompt(wm)
        # extra things to add to the prompt
        prompt_extra = ["-p", "Keybindings"]
    else:
        return False

    subprocess.run(prompt + prompt_extra, input=keybindings, text=True)

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
