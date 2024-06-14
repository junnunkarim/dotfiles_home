#!/usr/bin/env python

import sys
import subprocess
import argparse

from pathlib import Path as path


# ----------------
# helper functions
# ----------------
def get_screen_resolution() -> list[str] | None:
    # use xrandr to get screen information
    # was tested on 'xrandr' version 1.5.2
    command = ["xrandr"]
    output = subprocess.check_output(command).decode()

    for line in output.splitlines():
        if "current" in line:
            # extract screen resolution from 'xrandr' output
            resolution = line.split("current ")[1].split(",")[0].strip().split(" x ")
            break
    else:
        resolution = None

    return resolution


# --------------
# main functions
# --------------
def clipboard(menu: str, wm: str | None = None) -> bool:
    # currently only specifically patched 'dmenu' works
    if menu == "dmenu":
        screen_res = get_screen_resolution()

        if screen_res:
            # calculate screen dimensions to
            # display the menu at the center of the screen
            res_x, res_y = int(screen_res[0]), int(screen_res[1])
            width = 1000
            height = 40 * 10
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
                # "0",
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
            prompt = ["dmenu", "-h", "40", "-l", "12"]

        # extra things to add to the prompt
        prompt_extra = ["-p", "Clipboard:"]

        greenclip_history_cmd = ["greenclip", "print"]
        greenclip_execute_cmd = [
            "xargs",
            "-r",
            "-d",
            "\n",
            "-I",
            "{}",
            "greenclip",
            "print",
            "{}",
        ]

        # get clipboard history from greenclip
        greenclip_history = subprocess.run(
            greenclip_history_cmd, text=True, capture_output=True, check=True
        ).stdout.strip()

        # user selected history
        selection = subprocess.run(
            prompt + prompt_extra,
            input=greenclip_history,
            text=True,
            capture_output=True,
            check=True,
        ).stdout.strip()

        subprocess.run(
            greenclip_execute_cmd,
            input=selection,
            text=True,
            check=True,
        )
    elif menu == "rofi":
        # if 'wm' is not given, the if statment will be false
        script_path = path(
            f"~/.config/{wm}/external_configs/rofi/script_menu_1.rasi"
        ).expanduser()

        if script_path.is_file():
            # if config is found at specific directory, use it
            prompt = [
                "rofi",
                "-modi",
                '"clipboard:greenclip print"',
                "-show",
                "clipboard",
                "-run-command",
                "'{cmd}'",
                "-theme",
                f"{script_path}",
            ]
        else:
            # if window-manager name is not given,
            # use default 'rofi' theme
            prompt = [
                "rofi",
                "-modi",
                '"clipboard:greenclip print"',
                "-show",
                "clipboard",
                "-run-command",
                "'{cmd}'",
            ]

        subprocess.run(prompt, text=True, check=True)
    else:
        return False

    return True


def main() -> None:
    wms = ["dwm", "qtile"]
    menus = ["dmenu", "rofi"]

    arg_parser = argparse.ArgumentParser(description="spawn a popup clipboard")
    # define necessary cli arguments
    arg_parser.add_argument(
        "-m",
        "--menu",
        help="specify the menu launcher",
        choices=menus,
        # nargs=1,
        required=True,
    )
    arg_parser.add_argument(
        "-w",
        "--window-manager",
        help="specify the window manager",
        choices=wms,
        # nargs=1,
        # required=True,
    )

    # if no cli arguments are provided, show the help message and exit
    if len(sys.argv) <= 1:
        arg_parser.print_help()
        sys.exit(1)

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.window_manager:
        status_success = clipboard(menu=args.menu, wm=args.window_manager)
    elif args.menu:
        status_success = clipboard(menu=args.menu)
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
