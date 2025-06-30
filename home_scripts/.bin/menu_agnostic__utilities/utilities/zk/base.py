#!/usr/bin/env python

import os
import sys
import argparse
import pathlib

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))

from class__main.menus.dmenu import Dmenu
from class__main.menus.fuzzel import Fuzzel

from class__main.zk.base import ZkMenu


def zk(
    menu: str,
    terminal: str,
    notebook_dir: str = "/mnt/main/work/notebook/",
) -> None:
    max_str_len = 100

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
    else:
        sys.exit(f"Menu - '{menu}' is not recognized!")

    return_str = " Return"
    icon_menu: str = "󰍜"
    icon_tips: str = "󰔨"
    icon_enter: str = ""

    zk = ZkMenu(
        menu=menu_obj,
        notebook_dir=notebook_dir,
        editor_type="gui",
        terminal=terminal,
        # gui_editor="code",
        # gui_editor="emacsclient -nc",
        # gui_editor="emacs",
        gui_editor="zeditor",
        max_str_len=max_str_len,
        return_str=return_str,
        icon_menu=icon_menu,
        icon_tips=icon_tips,
        icon_enter=icon_enter,
    )

    entry_new = icon_menu + " new note "
    entry_new_fleeting = icon_menu + " new fleeting note "
    entry_new_daily = icon_menu + " new daily note "
    entry_new_monthly = icon_menu + " new monthly note "
    entry_all_notes = icon_menu + " all notes "
    entry_all_fleeting = icon_menu + " all fleeting notes "
    entry_all_daily = icon_menu + " all daily notes "
    entry_all_monthly = icon_menu + " all monthly notes "
    entry_delete = icon_menu + " delete notes "
    entry_all_tags = icon_menu + " all tags "
    entry_search_tags = icon_menu + " search by tags "

    menu_entries = [
        entry_new,
        entry_new_fleeting,
        entry_new_daily,
        entry_new_monthly,
        "",
        entry_all_notes,
        entry_all_tags,
        entry_search_tags,
        # entry_all_fleeting,
        # entry_all_daily,
        # entry_all_monthly,
        "",
        entry_delete,
        "----------------------------------------------------------------------------------------------------------------------",
    ]

    while True:
        notes_with_pending = zk.get_notes_by_tags(tags="pending")
        menu_entries_str = "\n".join(menu_entries) + "\n" + notes_with_pending

        selection = menu_obj.get_selection(
            entries=menu_entries_str,
            prompt_name="Notes: ",
        )

        if selection in menu_entries:
            if selection == entry_new:
                status = zk.create_new_note(note_type="new")

                if status:
                    break
            elif selection == entry_new_fleeting:
                status = zk.create_new_note(note_type="fleeting")

                if status:
                    break
            elif selection == entry_new_daily:
                status = zk.create_new_note(note_type="daily")

                if status:
                    break
            elif selection == entry_new_monthly:
                status = zk.create_new_note(note_type="monthly")

                if status:
                    break
            elif selection == entry_all_notes:
                status = zk.show_all_notes()

                if status:
                    break
            elif selection == entry_all_fleeting:
                zk.show_fleeting_notes()
            elif selection == entry_all_daily:
                zk.show_daily_notes()
            elif selection == entry_all_monthly:
                zk.show_monthly_notes()
            elif selection == entry_delete:
                zk.delete_notes()
            elif selection == entry_all_tags:
                status = zk.show_tags()

                if status:
                    break
            elif selection == entry_search_tags:
                zk.search_by_tags()
        elif not (selection in menu_entries):
            file_path = selection.split("(")[-1].strip()

            zk.open_note(file_path=file_path)
            break


def main() -> None:
    menus = ["dmenu", "fuzzel"]
    terminals = ["kitty", "alacritty", "mlterm", "konsole"]

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
        "-t",
        "--terminal",
        help="specify the teminal to open notebooks",
        choices=terminals,
        required=True,
    )
    arg_parser.add_argument(
        "-nd",
        "--notebook-dir",
        help="specify the 'zk' notebook directory",
    )

    # if no cli arguments are provided, show the help message and exit
    if len(sys.argv) <= 1:
        arg_parser.print_help()
        sys.exit()

    # parse all cli arguments
    args = arg_parser.parse_args()

    # 'window-manager' is accessed by 'window_manager'
    if args.menu and args.terminal and args.notebook_dir:
        zk(
            menu=args.menu,
            terminal=args.terminal,
            notebook_dir=str(pathlib.Path(args.key_file).expanduser()),
        )
    elif args.menu and args.terminal:
        zk(
            menu=args.menu,
            terminal=args.terminal,
        )
    else:
        arg_parser.print_help()
        sys.exit()


if __name__ == "__main__":
    main()
