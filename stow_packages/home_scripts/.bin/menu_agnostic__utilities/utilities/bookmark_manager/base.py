#!/usr/bin/env python

import os
import sys
import argparse
import pathlib

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))


from class__main.menus.dmenu import Dmenu
from class__main.menus.fuzzel import Fuzzel
from class__main.menus.rofi import Rofi

from class__main.bookmark_manager.buku import BukuMenu
from class__main.bookmark_manager.bkmr import BkmrMenu


def bookmark_manager(
    menu: str,
    bk_client: str,
    online_status: str,
    database_path: pathlib.Path | None = None,
) -> None:
    max_str_len = 150

    if menu == "dmenu":
        menu_obj = Dmenu(
            width=1400,
            line=15,
            fuzzy=False,
            # original_dmenu=True,
        )
    elif menu == "fuzzel":
        menu_obj = Fuzzel(
            width=120,
            line=16,
        )
    elif menu == "rofi":
        menu_obj = Rofi(
            line=12,
        )
    else:
        sys.exit(f"Menu - '{menu}' is not recognized!")

    editor_cmd = "emacs"
    return_str = " Return"
    icon_menu: str = "󰍜"
    icon_tips: str = "󰔨"
    icon_enter: str = ""

    if bk_client == "bkmr":
        bk_manager = BkmrMenu(
            menu=menu_obj,
            max_str_len=max_str_len,
            return_str=return_str,
            icon_menu=icon_menu,
            icon_tips=icon_tips,
            icon_enter=icon_enter,
            online_status=online_status,
        )
    else:
        bk_manager = BukuMenu(
            menu=menu_obj,
            database_path=database_path,
            editor_cmd=editor_cmd,
            max_str_len=max_str_len,
            online_status=online_status,
            return_str=return_str,
            icon_menu=icon_menu,
            icon_tips=icon_tips,
            icon_enter=icon_enter,
        )

    bk_manager.run()


def main() -> None:
    menus = ["dmenu", "fuzzel", "rofi"]
    bk_clients = ["bkmr", "buku"]
    modes = ["online", "offline"]

    arg_parser = argparse.ArgumentParser(description="buku bookmark manager")
    # define necessary cli arguments
    arg_parser.add_argument(
        "-m",
        "--menu",
        help="specify the menu launcher",
        choices=menus,
        required=True,
    )
    arg_parser.add_argument(
        "-b",
        "--bookmark_client",
        help="specify the bookmark client",
        choices=bk_clients,
        required=True,
    )
    arg_parser.add_argument(
        "-os",
        "--online-status",
        help="specify if you want buku to fetch from online when adding new bookmarks",
        choices=modes,
        required=True,
    )
    arg_parser.add_argument(
        "-db",
        "--db-path",
        help="specify the sqlite3 database containing all buku bookmarks",
    )

    # if no cli arguments are provided, show the help message and exit
    if len(sys.argv) <= 1:
        arg_parser.print_help()
        sys.exit()

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.online_status and args.db_path:
        bookmark_manager(
            menu=args.menu,
            bk_client=args.bookmark_client,
            online_status=args.online_status,
            database_path=pathlib.Path(args.key_file).expanduser(),
        )
    elif args.menu and args.online_status:
        bookmark_manager(
            menu=args.menu,
            bk_client=args.bookmark_client,
            online_status=args.online_status,
        )
    else:
        arg_parser.print_help()
        sys.exit()


if __name__ == "__main__":
    main()
