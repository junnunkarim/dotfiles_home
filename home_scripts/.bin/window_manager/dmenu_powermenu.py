#!/usr/bin/env python

import sys
import subprocess
import argparse

from pathlib import Path as path


# ----------------
# helper functions
# ----------------
def get_uptime() -> str:
    output = subprocess.run(
        ["uptime", "-p"], text=True, capture_output=True, check=True
    ).stdout.strip()

    return (
        output.replace("up ", "")
        .replace("hours", "h")
        .replace("hour", "h")
        .replace("minutes", "min")
        .replace("minute", "min")
    )


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


# -------------------------------
# functions creating menu prompts
# -------------------------------
def dmenu_prompt() -> list:
    screen_res = get_screen_resolution()

    if screen_res:
        # calculate screen dimensions to
        # display the menu at the center of the screen
        res_x, res_y = int(screen_res[0]), int(screen_res[1])
        width = 500
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
            "10",
            "-W",
            f"{width}",
            "-X",
            f"{x}",
            "-Y",
            f"{y}",
        ]
    else:
        # if can't get screen resolution, use the default prompt
        # main prompt
        prompt = ["dmenu", "-h", "45", "-l", "12"]

    return prompt


def rofi_prompt(wm: None | str) -> list:
    # if 'wm' is not given, the if statment will be false
    script_path = path(
        f"~/.config/{wm}/external_configs/rofi/script_menu.rasi"
    ).expanduser()

    if script_path.is_file():
        # if config is found at specific directory, use it
        prompt = ["rofi", "-dmenu", "-i", "-theme", f"{script_path}"]
    else:
        # else use default config
        prompt = ["rofi", "-dmenu", "-i"]

    return prompt


# --------------
# main functions
# --------------
def powermenu(menu: str, wm: str | None = None) -> bool:
    uptime = f"Uptime - {get_uptime()}:"
    host = get_hostname()

    # currently only specifically patched 'dmenu' works
    if menu == "dmenu":
        prompt = dmenu_prompt()
        # extra things to add to the prompt
        prompt_extra = ["-p", uptime]
    elif menu == "rofi":
        prompt = rofi_prompt(wm)
        # extra things to add to the prompt
        prompt_extra = ["-p", host, "-mesg", uptime]
    else:
        return False

    entries = {
        "cancel": " Cancel",
        "hibernate": " Hibernate",
        "shutdown": " Shutdown",
        "reboot": "󰜉 Reboot",
        "suspend": "󰒲 Suspend",
        "lock": " Lock",
    }

    # if 'wm' is given show logout option
    if wm:
        entries["logout"] = "󰗽 Logout"

    # encode every entry in the dictionary with as a
    # string with newline at the end of each entry
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
        elif wm:
            if choice == "logout":
                logout(wm)

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
        required=True,
    )
    arg_parser.add_argument(
        "-w",
        "--window-manager",
        help="specify the window manager",
        choices=wms,
    )

    # if no cli arguments are provided, show the help message and exit
    if len(sys.argv) <= 1:
        arg_parser.print_help()
        sys.exit(1)

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.window_manager:
        status_success = powermenu(menu=args.menu, wm=args.window_manager)
    elif args.menu:
        status_success = powermenu(menu=args.menu)
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
