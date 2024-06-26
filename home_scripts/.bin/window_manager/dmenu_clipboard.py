#!/usr/bin/env python

from sys import argv
from argparse import ArgumentParser
from pathlib import Path
from subprocess import run, check_output

from helper.class_dmenu import Dmenu
from helper.functions import fail_exit


# --------------
# main functions
# --------------
def clipboard(menu: str, wm: str | None = None) -> None:
    if menu == "dmenu":
        menu_obj = Dmenu(
            width=950,
            line=12,
        )

        greenclip_history_cmd = ["greenclip", "print"]
        # get clipboard history from greenclip
        greenclip_history = check_output(greenclip_history_cmd)

        # user selected history
        selection = menu_obj.get_selection(
            entries=greenclip_history.decode(),
            prompt_name="Clipboard:",
        )

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

        run(
            greenclip_execute_cmd,
            input=selection,
            text=True,
        )
    # elif menu == "rofi":
    #     # if 'wm' is not given, the if statment will be false
    #     script_path = Path(
    #         f"~/.config/{wm}/external_configs/rofi/script_menu_1.rasi"
    #     ).expanduser()
    #
    #     if script_path.is_file():
    #         # if config is found at specific directory, use it
    #         prompt = [
    #             "rofi",
    #             "-modi",
    #             '"clipboard:greenclip print"',
    #             "-show",
    #             "clipboard",
    #             "-run-command",
    #             "'{cmd}'",
    #             "-theme",
    #             f"{script_path}",
    #         ]
    #     else:
    #         # if window-manager name is not given,
    #         # use default 'rofi' theme
    #         prompt = [
    #             "rofi",
    #             "-modi",
    #             '"clipboard:greenclip print"',
    #             "-show",
    #             "clipboard",
    #             "-run-command",
    #             "'{cmd}'",
    #         ]
    #
    #     run(prompt, text=True, check=True)
    else:
        fail_exit(error=f"Menu - '{menu}' is not recognized!")
        return  # for supressing warnings


def main() -> None:
    wms = ["dwm"]
    menus = ["dmenu"]

    arg_parser = ArgumentParser(description="open clipboard")
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
        clipboard(menu=args.menu, wm=args.window_manager)
    elif args.menu:
        clipboard(menu=args.menu)
    else:
        arg_parser.print_help()
        fail_exit()


if __name__ == "__main__":
    main()
