#!/usr/bin/env python

from sys import argv
from argparse import ArgumentParser
from pathlib import Path
from re import compile as re_compile

from helper.class_dmenu import Dmenu
from helper.functions import fail_exit


# ----------------
# helper functions
# ----------------
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
    wm: str, file_path: Path | None = None, max_length: int = 200
) -> list[str]:
    if not file_path:
        if wm == "dwm":
            file_path = Path("~/.config/dwm/src/config.h").expanduser()
        # elif wm == "qtile":
        #     file_path = f"{path('~/.config/dwm/src/config.h').expanduser()}"
        else:
            fail_exit(error=f"{wm} config file with keybindings not found!")
            return []

    if not file_path.is_file():
        fail_exit(error=f"{wm} config file with keybindings not found!")

    # Regular expression to match the desired comment pattern
    if wm == "dwm":
        pattern = re_compile(r"//desc:\s*(.+?)\s*\|\s*(.+)")
    elif wm == "qtile":
        pattern = re_compile(r"#desc:\s*(.+?)\s*\|\s*(.+)")
    else:
        fail_exit(error=f"Window manager - {wm} is not supported!")
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
# def rofi_prompt(wm: None | str) -> list:
#     # if 'wm' is not given, the if statment will be false
#     script_path = Path(
#         f"~/.config/{wm}/external_configs/rofi/script_menu_1.rasi"
#     ).expanduser()
#
#     if not script_path.is_file():
#         # if window-manager name is not given,
#         # use default 'rofi' theme
#         return ["rofi", "-dmenu"]
#
#     # if config is found at specific directory, use it
#     return ["rofi", "-dmenu", "-theme", f"{script_path}"]
#


# --------------
# main functions
# --------------
def keybindings(menu: str, wm: str, file_path: Path | None = None) -> None:
    str_width = 85
    keybindings = parse_keybindings(wm, file_path, str_width)

    if not keybindings:
        fail_exit(error="Keybindings for {wm} is empty")
        return

    keybindings = "\n".join(keybindings)

    if menu == "dmenu":
        menu_obj = Dmenu(
            width=950,
            line=12,
        )
    # elif menu == "rofi":
    #     prompt = rofi_prompt(wm)
    #     # extra things to add to the prompt
    #     prompt_extra = ["-p", "Keybindings"]
    else:
        fail_exit(error=f"Menu - '{menu}' is not recognized!")
        return  # for supressing warnings

    menu_obj.show(
        entries=keybindings,
        prompt_name="Keybindings:",
    )


def main() -> None:
    wms = ["dwm"]
    menus = ["dmenu"]

    arg_parser = ArgumentParser(description="show all keybindings")
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
    if len(argv) <= 1:
        arg_parser.print_help()
        fail_exit()

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.window_manager and args.file_path:
        keybindings(
            menu=args.menu,
            wm=args.window_manager,
            file_path=Path(args.key_file).expanduser(),
        )
    elif args.menu and args.window_manager:
        keybindings(menu=args.menu, wm=args.window_manager)
    else:
        arg_parser.print_help()
        fail_exit()


if __name__ == "__main__":
    main()
