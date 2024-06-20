#!/usr/bin/env python

from sys import argv
from argparse import ArgumentParser
from pathlib import Path
from subprocess import run

from helper.class_dmenu import Dmenu
from helper.functions import fail_exit


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
        .replace("minutes", "min")
        .replace("minute", "min")
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
        fail_exit(error=f"Window manager - {wm} is not supported!")


# -------------------------------
# functions creating menu prompts
# -------------------------------
def rofi_prompt(wm: None | str) -> list:
    # if 'wm' is not given, the if statment will be false
    script_path = Path(
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
def powermenu(menu: str, wm: str | None = None) -> None:
    uptime = f"{get_uptime()}:"
    host = get_hostname()
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

    # currently only specifically patched 'dmenu' works
    if menu == "dmenu":
        menu_obj = Dmenu(
            width=500,
            line=len(entries),
        )
    # elif menu == "rofi":
    #     prompt = rofi_prompt(wm)
    #     # extra things to add to the prompt
    #     prompt_extra = ["-p", host, "-mesg", uptime]
    else:
        fail_exit(error=f"Menu - '{menu}' is not recognized!")
        return  # for supressing warnings

    # encode every entry in the dictionary with as a
    # string with newline at the end of each entry
    options = "\n".join(entries.values())

    selection = menu_obj.get_selection(
        entries=options,
        prompt_name="(" + host + ") " + uptime,
    )

    # selected option
    choice = next((key for key, value in entries.items() if value == selection), "")

    if (choice != "cancel") and menu_obj.get_confirmation():
        if choice == "hibernate":
            run(
                ["systemctl", "hibernate"],
                text=True,
            )
        elif choice == "shutdown":
            run(
                ["systemctl", "poweroff"],
                text=True,
            )
        elif choice == "reboot":
            run(
                ["systemctl", "reboot"],
                text=True,
            )
        elif choice == "suspend":
            run(
                ["systemctl", "suspend"],
                text=True,
            )
        elif choice == "lock":
            run(
                ["betterlockscreen", "-l"],
                text=True,
                check=False,
            )
        elif wm:
            if choice == "logout":
                logout(wm)


def main() -> None:
    wms = ["dwm"]
    menus = ["dmenu"]

    arg_parser = ArgumentParser(description="spawn a popup clipboard")
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
        fail_exit()

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.window_manager:
        powermenu(menu=args.menu, wm=args.window_manager)
    elif args.menu:
        powermenu(menu=args.menu)
    else:
        arg_parser.print_help()
        fail_exit()


if __name__ == "__main__":
    main()
