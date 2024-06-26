#!/usr/bin/env python

import sys
import argparse
import pathlib

from helper.class_menu import Menu
from helper.class_dmenu import Dmenu
from helper.class_buku_dmenu import BukuDmenu
from helper.functions import fail_exit


def buku(
    menu: str, mode_of_operation: str, database_path: pathlib.Path | None = None
) -> None:
    max_str_len = 150

    if menu == "dmenu":
        menu_obj = Dmenu(
            width=1400,
            line=15,
            fuzzy=False,
            # original_dmenu=True,
        )
    else:
        fail_exit(error=f"Menu - '{menu}' is not recognized!")
        return  # for supressing warnings

    return_str = " Return"
    icon_menu: str = "󰍜"
    icon_tips: str = "󰔨"
    icon_enter: str = ""

    buku = BukuDmenu(
        menu=menu_obj,
        database_path=database_path,
        attr_to_show=["id", "title", "tags"],
        max_str_len=max_str_len,
        mode_of_operation=mode_of_operation,
        return_str=return_str,
        icon_menu=icon_menu,
        icon_tips=icon_tips,
        icon_enter=icon_enter,
    )

    menu_entries = [
        icon_menu + " add new bookmark ",
        icon_menu + " edit bookmark ",
        icon_menu + " delete bookmark ",
        icon_menu + " show all tags ",
        "",  # for adding an empty line
    ]

    while True:
        selection = buku.get_selection(
            menu_entries=menu_entries,
            prompt_name="Bookmarks",
        )

        if selection in menu_entries:
            if selection == menu_entries[0]:
                buku.add_edit_bookmark()
            elif selection == menu_entries[1]:
                buku.edit_bookmark()
            elif selection == menu_entries[2]:
                buku.delete_bookmark()
            elif selection == menu_entries[3]:
                status = buku.show_tags()

                if status:
                    break
        elif not (selection in menu_entries):
            bookmark_id = int(selection.split(" ")[0])

            buku.open_bookmark(id=bookmark_id)
            break


def main() -> None:
    menus = ["dmenu"]
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
        "-md",
        "--mode",
        help="specify the mode to operate when adding new bookmarks",
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
        fail_exit()

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.mode and args.db_path:
        buku(
            menu=args.menu,
            mode_of_operation=args.mode,
            database_path=pathlib.Path(args.key_file).expanduser(),
        )
    elif args.menu and args.mode:
        buku(
            menu=args.menu,
            mode_of_operation=args.mode,
        )
    else:
        arg_parser.print_help()
        fail_exit()


if __name__ == "__main__":
    main()
