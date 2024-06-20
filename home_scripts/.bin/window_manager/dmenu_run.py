#!/usr/bin/env python

import concurrent.futures

from subprocess import Popen
from sys import argv
from os import path
from glob import glob
from argparse import ArgumentParser
from pathlib import Path

from helper.class_dmenu import Dmenu
from helper.functions import fail_exit


# ----------------
# helper functions
# ----------------
def process_file(file_path: Path) -> tuple[str, dict] | None:
    name = None
    generic_name = None
    keywords = None
    comment = None
    # categories = None
    no_display = None

    with open(file_path, "r", encoding="utf-8") as file:
        for line in file:
            if (not name) and line.startswith("Name="):
                name = line.strip().split("=", 1)[1]
            elif (not generic_name) and line.startswith("GenericName="):
                generic_name = line.strip().split("=", 1)[1].lower()
            elif (not keywords) and line.startswith("Keywords="):
                keywords = (
                    line.strip().split("=", 1)[1].replace(";", " ").strip().lower()
                )
            elif (not comment) and line.startswith("Comment="):
                comment = line.strip().split("=", 1)[1]
            # elif (not categories) and line.startswith("Categories="):
            # categories = line.strip().split("=", 1)[1].replace(";", " ").strip()
            elif line.startswith("NoDisplay="):
                no_display = line.strip().split("=", 1)[1].lower() == "true"

            # if (not no_display) and name:
            #     break

    if (not no_display) and name:
        return name.title(), {
            "generic_name": generic_name,
            "keywords": keywords,
            "comment": comment,
            # "categories": categories,
            "file_path": file_path,
        }
    return None


def get_desktop_entries() -> dict:
    # define the directories to search
    directories = [
        "/usr/share/applications/",
        path.expanduser("~/.local/share/applications"),
    ]

    desktop_files_dict = {}

    # collect all .desktop file paths
    all_desktop_files = []
    for directory in directories:
        all_desktop_files.extend(glob(path.join(directory, "*.desktop")))

    # use ThreadPoolExecutor to process files concurrently
    with concurrent.futures.ThreadPoolExecutor() as executor:
        futures = {
            executor.submit(process_file, file_path): file_path
            for file_path in all_desktop_files
        }
        for future in concurrent.futures.as_completed(futures):
            result = future.result()

            if result:
                name, data = result
                keywords = data.get("keywords", None)
                generic_name = data.get("generic_name", None)
                comment = data.get("comment", None)

                if keywords:
                    name = f"{name} [{keywords}]"

                if not keywords and generic_name:
                    name = f"{name} [{generic_name}]"

                if comment:
                    name = f"{name} ({comment})"

                desktop_files_dict[name] = data

    return desktop_files_dict


# --------------
# main functions
# --------------
def run(menu: str, term: str, wm: str | None = None) -> None:
    desktop_entries = get_desktop_entries()

    if menu == "dmenu":
        menu_obj = Dmenu(
            width=1000,
            line=10,
            fuzzy=False,
        )
    # elif menu == "rofi":
    #     prompt = rofi_prompt(wm)
    #     # extra things to add to the prompt
    #     prompt_extra = []
    else:
        fail_exit(error=f"Menu - '{menu}' is not recognized!")
        return  # for supressing warnings

    entries = "\n".join(sorted(desktop_entries.keys()))

    selection = menu_obj.get_selection(
        entries=entries,
        prompt_name="App Launcher:",
    )

    execute_cmd = [
        "dex",
        "--term",
        term,
        desktop_entries[selection]["file_path"],
    ]

    Popen(
        execute_cmd,
        start_new_session=True,
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
        "-t",
        "--terminal",
        help="specify the terminal to open programs that depend on terminal",
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
        run(menu=args.menu, term=args.terminal, wm=args.window_manager)
    elif args.menu:
        run(menu=args.menu, term=args.terminal)
    else:
        arg_parser.print_help()
        fail_exit()


if __name__ == "__main__":
    main()
