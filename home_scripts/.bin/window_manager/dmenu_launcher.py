#!/usr/bin/env python

from sys import argv
from argparse import ArgumentParser
from pathlib import Path

from helper.class_dmenu import Dmenu
from helper.functions import fail_exit


# -------------------------------
# functions creating menu prompts
# -------------------------------
def rofi_prompt(wm: None | str) -> list:
    # if 'wm' is not given, the if statment will be false
    script_path = Path(
        f"~/.config/{wm}/external_configs/rofi/launcher.rasi"
    ).expanduser()

    if script_path.is_file():
        # if config is found at specific directory, use it
        prompt = [
            "rofi",
            "-show",
            "drun",
            "-theme",
            f"{script_path}",
        ]
    else:
        # if window-manager name is not given,
        # use default 'rofi' theme
        prompt = [
            "rofi",
            "-show",
            "drun",
        ]

    return prompt


# --------------
# main functions
# --------------
def launcher(menu: str, wm: str | None = None) -> None:
    # currently only specifically patched 'dmenu' works
    if menu == "dmenu":
        menu_obj = Dmenu(
            width=500,
            line=10,
            dmenu_run=True,
        )
    # elif menu == "rofi":
    #     prompt = rofi_prompt(wm)
    #     # extra things to add to the prompt
    #     prompt_extra = []
    else:
        fail_exit(error=f"Menu - '{menu}' is not recognized!")
        return  # for supressing warnings

    menu_obj.show_app_launcher(
        prompt_name="App Launcher:",
    )


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
        # required=True,
    )

    # if no cli arguments are provided, show the help message and exit
    if len(argv) <= 1:
        arg_parser.print_help()
        fail_exit()

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.window_manager:
        launcher(menu=args.menu, wm=args.window_manager)
    elif args.menu:
        launcher(menu=args.menu)
    else:
        arg_parser.print_help()
        fail_exit()


if __name__ == "__main__":
    main()
