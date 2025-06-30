#!/usr/bin/env python

import sys
import subprocess
import argparse

from pathlib import Path

# map each utility name to the path of its script
UTILITY_SCRIPTS = {
    "app_launcher": Path(
        "~/.bin/menu_agnostic__utilities/utilities/app_launcher/base.py"
    ).expanduser(),
    "bookmark_manager": Path(
        "~/.bin/menu_agnostic__utilities/utilities/bookmark_manager/base.py"
    ).expanduser(),
    "colorscheme_switcher": Path(
        "~/.bin/menu_agnostic__utilities/utilities/colorscheme_switcher/base.py"
    ).expanduser(),
    "clipboard": Path(
        "~/.bin/menu_agnostic__utilities/utilities/clipboard/base.py"
    ).expanduser(),
    "manage_clients": Path(
        "~/.bin/menu_agnostic__utilities/utilities/client_manager/base.py"
    ).expanduser(),
    "show_keybindings": Path(
        "~/.bin/menu_agnostic__utilities/utilities/show_keybindings/base.py"
    ).expanduser(),
    "powermenu": Path(
        "~/.bin/menu_agnostic__utilities/utilities/powermenu/base.py"
    ).expanduser(),
    "zk": Path("~/.bin/menu_agnostic__utilities/utilities/zk/base.py").expanduser(),
    # add additional utilities here
}


def dispatch_utility(utility_name: str, util_args: list) -> None:
    if utility_name not in UTILITY_SCRIPTS:
        print(f"Error: Unknown utility '{utility_name}'.")
        sys.exit(1)

    script_path = UTILITY_SCRIPTS[utility_name]
    # build the command to run
    # using sys.executable ensures the same python interpreter is used
    command = [sys.executable, script_path] + util_args

    try:
        # call the utility script
        # this call waits until the script completes
        subprocess.run(command, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Utility script '{utility_name}' failed with error: {e}")
        sys.exit(e.returncode)


def main():
    parser = argparse.ArgumentParser(description="Dispatcher for utility scripts")
    # 'utility' is the name of the utility to run (must be one of the keys in UTILITY_SCRIPTS)
    parser.add_argument(
        "utility",
        help="Name of the utility to run",
        choices=list(UTILITY_SCRIPTS.keys()),
    )
    # all remaining arguments will be passed directly to the chosen script
    parser.add_argument(
        "utility_args",
        nargs=argparse.REMAINDER,
        help="Arguments for the utility script",
    )

    args = parser.parse_args()

    dispatch_utility(args.utility, args.utility_args)


if __name__ == "__main__":
    main()
