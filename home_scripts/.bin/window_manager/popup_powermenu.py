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
    print("\tspawn a popup powermenu.")
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


def get_uptime() -> str:
    return subprocess.run(
        ["uptime", "-p"], text=True, capture_output=True, check=True
    ).stdout.strip()[3:]


def get_hostname() -> str:
    return subprocess.run(
        ["cat", "/proc/sys/kernel/hostname"], text=True, capture_output=True, check=True
    ).stdout.strip()


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


def get_confirmation(menu: str, prompt: list) -> bool:
    yes = " Yes"
    no = " No"

    if menu == "dmenu":
        prompt_extra = ["-p", "Are you sure?"]
    elif menu == "rofi":
        prompt_extra = ["-p", "Confirmation", "-mesg", "Are you sure?"]
    else:
        prompt_extra = []

    selection = subprocess.run(
        prompt + prompt_extra,
        input=f"{yes}\n{no}",
        text=True,
        capture_output=True,
        check=True,
    ).stdout.strip()

    if selection == yes:
        return True
    else:
        return False


def logout(wm: str) -> None:
    if wm == "awesome":
        subprocess.run(
            ["awesome-client", "'awesome.quit()'"],
            text=True,
            check=True,
        )
    elif wm == "dwm":
        subprocess.run(
            ["pkill", "-TERM", "-x", "dwm"],
            text=True,
            check=True,
        )
    elif wm == "hyprland":
        subprocess.run(
            ["hyprctl", "dispatch", "exit"],
            text=True,
            check=True,
        )
    elif wm == "i3":
        subprocess.run(
            ["i3-msg", "exit"],
            text=True,
            check=True,
        )
    elif wm == "openbox":
        subprocess.run(
            ["openbox", "--exit"],
            text=True,
            check=True,
        )
    elif wm == "qtile":
        subprocess.run(
            ["qtile", "cmd-obj", "-o", "cmd", "-f", "shutdown"],
            text=True,
            check=True,
        )


# --------------
# main functions
# --------------
def powermenu(wm: str, menu: str) -> None:
    uptime = "Uptime: " + get_uptime()
    host = get_hostname()

    if menu == "dmenu":
        screen_res = get_screen_resolution()

        if screen_res:
            res_x, res_y = int(screen_res[0]), int(screen_res[1])
            width = 500
            height = 40 * 10
            x = (res_x // 2) - (width // 2)
            y = (res_y // 2) - (height // 2)

            prompt = [
                "dmenu",
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
            prompt = ["dmenu", "-h", "40", "-l", "12"]

        prompt_extra = ["-p", uptime]
    elif menu == "rofi":
        script_path = path(
            f"~/.config/{wm}/external_configs/rofi/script_menu.rasi"
        ).expanduser()

        prompt = ["rofi", "-dmenu", "-i", "-theme", f"{script_path}"]
        prompt_extra = ["-p", host, "-mesg", uptime]
    else:
        print(f"Error! '{menu}' not found!")
        sys.exit()

    entries = {
        "hibernate": " Hibernate",
        "shutdown": " Shutdown",
        "reboot": "󰜉 Reboot",
        "suspend": "󰒲 Suspend",
        "lock": " Lock",
        "logout": "󰗽 Logout",
        "cancel": "󰖭 Cancel",
    }

    options = "\n".join(entries.values())

    selection = subprocess.run(
        prompt + prompt_extra, input=options, text=True, capture_output=True, check=True
    ).stdout.strip()

    # selected option
    choice = next((key for key, value in entries.items() if value == selection), "")

    if (choice != "cancel") and get_confirmation(menu, prompt):
        if choice == "hibernate":
            subprocess.run(["systemctl", "hibernate"], text=True, check=False)
        elif choice == "shutdown":
            subprocess.run(["systemctl", "poweroff"], text=True, check=False)
        elif choice == "reboot":
            subprocess.run(["systemctl", "reboot"], text=True, check=False)
        elif choice == "suspend":
            subprocess.run(["systemctl", "suspend"], text=True, check=False)
        elif choice == "lock":
            subprocess.run(["betterlockscreen", "-l"], text=True, check=False)
        elif choice == "logout":
            logout(wm)


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
    elif (argv[1] in arg_wm) and (argv[3] in arg_menu):
        if (argv[2] in wms) and (argv[4] in menus):
            powermenu(wm=argv[2], menu=argv[4])
        else:
            usage(script_name=argv[0], wm_fail=argv[2], menu_fail=argv[4])
    elif (argv[1] in arg_menu) and (argv[3] in arg_wm):
        if (argv[2] in menus) and (argv[4] in wms):
            powermenu(wm=argv[4], menu=argv[2])
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
