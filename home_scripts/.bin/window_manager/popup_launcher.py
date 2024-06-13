#!/usr/bin/env python

import sys
import subprocess

from pathlib import Path as path


# ----------------
# helper functions
# ----------------
def usage(script_name: str, wm_fail="", menu_fail="") -> None:
    if wm_fail:
        print(f"  Error! '{wm_fail}' is not supported!")
    if menu_fail:
        print(f"  Error! '{menu_fail}' is not supported!")
        print()

    print("  description:")
    print("\tspawn a popup app launcher.")
    print("\tNOTE: both '-w' and '-m' arguments must be provided.")
    print("  usage:")
    print(f"\t{script_name} [option]")
    print()
    print("  arguments:")
    print("\t-h, --help")
    print("\t\tshow this help message.")
    print()
    print("\t-w, --window-manager")
    print("\t\tset the window manager.")
    print()
    print("\t-m, --menu")
    print("\t\tset the menu launcher.")

    sys.exit()


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


# --------------
# main functions
# --------------
def launcher(wm: str, menu: str):
    if menu == "dmenu":
        screen_res = get_screen_resolution()

        if screen_res:
            res_x, res_y = int(screen_res[0]), int(screen_res[1])
            width = 500
            height = 40 * 10
            x = (res_x // 2) - (width // 2)
            y = (res_y // 2) - (height // 2)

            prompt = [
                "dmenu_run",
                "-h",
                "40",
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
            prompt = ["dmenu_run", "-h", "40", "-l", "12"]

        prompt_extra = ["-p", "App Launcher:"]
    elif menu == "rofi":
        script_path = path(
            f"~/.config/{wm}/external_configs/rofi/launcher.rasi"
        ).expanduser()

        prompt = [
            "rofi",
            "-show",
            "drun",
            "-theme",
            f"{script_path}",
        ]
        prompt_extra = []
    else:
        print(f"Error! '{menu}' not found!")
        sys.exit()

    subprocess.run(prompt + prompt_extra, text=True, check=True)


def main(argc: int, argv: list) -> None:
    arg_help = ["-h", "--help"]
    arg_wm = ["-w", "--window-manager"]
    arg_menu = ["-m", "--menu"]

    wms = ["dwm", "qtile"]
    menus = ["dmenu", "rofi"]

    fail = False

    if argc <= 1:
        fail = True
    elif (argv[1] in arg_help) or (argc <= 4):
        fail = True
    # if first argument is '-w' and second argument is '-m'
    elif (argv[1] in arg_wm) and (argv[3] in arg_menu):
        if (argv[2] in wms) and (argv[4] in menus):
            launcher(wm=argv[2], menu=argv[4])
        else:
            usage(script_name=argv[0], wm_fail=argv[2], menu_fail=argv[4])
    # if first argument is '-m' and second argument is '-w'
    elif (argv[1] in arg_menu) and (argv[3] in arg_wm):
        if (argv[2] in menus) and (argv[4] in wms):
            launcher(wm=argv[4], menu=argv[2])
        else:
            usage(script_name=argv[0], wm_fail=argv[4], menu_fail=argv[2])
    else:
        sys.exit()

    if fail:
        usage(script_name=argv[0])
    else:
        sys.exit()


if __name__ == "__main__":
    # all cli arguments
    argv = sys.argv
    # number of cli arguments
    argc = len(argv)

    main(argc, argv)
