#!/usr/bin/env python3

import subprocess
import argparse
import sys

from pathlib import Path


def change_wallpaper(wallpaper: str, directory: str = "~/.config/wallpaper/"):
    # add `/` at the end if not added by the user
    if directory[-1] != "/":
        directory = directory + "/"

    # print(wallpaper)
    # print(directory)
    wall_directory = Path(directory + wallpaper).expanduser()

    cmd = [
        "swww",
        "img",
        "--transition-type",
        "any",
        "--transition-fps",
        "60",
        "--transition-duration",
        "2",
        f"{wall_directory}",
    ]
    subprocess.run(cmd, encoding="utf-8")


# main function to handle the cli arguments
def main():
    parser = argparse.ArgumentParser(description="Change wallpaper with swww.")
    parser.add_argument(
        "-w", "--wallpaper", help="Wallpaper name (with extension)", required=True
    )
    parser.add_argument("-d", "--directory", help="Wallpaper directory")

    # if no cli arguments are provided, show the help message and exit
    if len(sys.argv) <= 1:
        parser.print_help()
        sys.exit()

    args = parser.parse_args()

    if args.wallpaper and args.directory:
        change_wallpaper(wallpaper=args.wallpaper, directory=args.directory)
    elif args.wallpaper:
        change_wallpaper(wallpaper=args.wallpaper)
    else:
        print("No valid option provided.\n")
        parser.print_help()


if __name__ == "__main__":
    main()
