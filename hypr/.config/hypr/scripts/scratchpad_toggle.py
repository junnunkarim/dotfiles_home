#!/usr/bin/env python3

import subprocess
import shlex
import argparse
import sys
import json


def get_class_names(clients: list) -> list:
    return [client["class"] for client in clients]


def get_hypr_client_info():
    cmd = "hyprctl clients -j"
    result = subprocess.run(shlex.split(cmd), capture_output=True, text=True)

    return json.loads(result.stdout)


def toggle_scratchpad(
    scratch_name: str,
    program_cmd: str = "",
    extra_rules: str = "",
    start_program: bool = False,
):
    if start_program:
        subprocess.run(
            shlex.split(
                f"hyprctl dispatch -- exec [workspace {scratch_name}; {extra_rules}] "
                + program_cmd
            ),
            capture_output=False,
            start_new_session=True,
        )
        subprocess.run(
            shlex.split(f"hyprctl dispatch togglespecialworkspace {scratch_name}"),
            capture_output=False,
            start_new_session=True,
        )
    else:
        subprocess.run(
            shlex.split("hyprctl dispatch togglespecialworkspace " + scratch_name),
            capture_output=False,
            start_new_session=True,
        )


def handle_scratchpad(
    program_cmd: str = "",
    window_rules: str = "",
    match_name: str = "",
    scratch_name: str = "",
):
    client_info = get_hypr_client_info()
    class_names = get_class_names(client_info)
    print(class_names)

    if not match_name in class_names:
        toggle_scratchpad(
            scratch_name,
            program_cmd=program_cmd,
            extra_rules=window_rules,
            start_program=True,
        )
    else:
        toggle_scratchpad(scratch_name)


# main function to handle the cli arguments
def main():
    parser = argparse.ArgumentParser(description="Toggle Hyprland scratchpads.")
    parser.add_argument(
        "-p",
        "--program_cmd",
        help="program command to launch in the scratchpad",
        required=True,
    )
    parser.add_argument(
        "-r",
        "--window_rules",
        help="window rules to consider when launching the program (must be semicolon separated)",
        required=True,
    )
    parser.add_argument(
        "-m",
        "--match",
        help="class-name for finding out if a instance of the program is open",
        required=True,
    )
    parser.add_argument(
        "-s",
        "--scratch",
        help="scratchpad workspace name",
        required=True,
    )

    # if no cli arguments are provided, show the help message and exit
    if len(sys.argv) <= 1:
        parser.print_help()
        sys.exit()

    args = parser.parse_args()

    if args.program_cmd and args.window_rules and args.match and args.scratch:
        handle_scratchpad(args.program_cmd, args.window_rules, args.match, args.scratch)
    else:
        parser.print_help()
        sys.exit()


if __name__ == "__main__":
    main()
