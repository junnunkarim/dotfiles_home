#!/usr/bin/env python3

import os
import sys
import subprocess
import shutil
import argparse

from datetime import datetime

HOME: str = str(os.environ.get("HOME"))


def create_backup(entry: str, backup_path: str):
    print("Backup:")

    if os.path.islink(entry):
        print(f"\t`{entry}` is a symlink. No need to backup.")
        print(f"\tOnly removing symlink: {entry}")

        try:
            os.unlink(entry)
        except Exception as e:
            print(f"Error removing symlink: {e}")
            sys.exit(1)
    else:
        print(f"\tDirectory/File `{entry}` exists. Taking backup...")

        os.makedirs(backup_path, exist_ok=True)

        new_dir_name = entry.split("/")[-1]
        destination = os.path.join(backup_path, new_dir_name)

        print(f"\tMoving {entry} to {destination}")

        try:
            shutil.move(entry, destination)
        except Exception as e:
            print(f"Error moving directory: {e}")
            sys.exit(1)


def backup(package: str, stow_directory: str):
    package_path = os.path.join(stow_directory, package)

    timestamp = datetime.now().strftime("%Y_%m_%d__%H_%M_%S")
    backup_path = os.path.join(HOME, "dotfiles_backup", timestamp)
    os.makedirs(backup_path, exist_ok=True)

    for entry in os.listdir(package_path):
        if entry == ".config":
            backup_dir = os.path.join(backup_path, ".config")

            for subentry in os.listdir(os.path.join(package_path, entry)):
                dir_to_check = os.path.join(HOME, entry, subentry)

                if os.path.exists(dir_to_check):
                    create_backup(entry=dir_to_check, backup_path=backup_dir)
        elif entry == ".local":
            backup_dir = os.path.join(backup_path, ".local", "share")

            for subentry in os.listdir(os.path.join(package_path, entry, "share")):
                dir_to_check = os.path.join(HOME, entry, "share", subentry)
                print(dir_to_check)

                if os.path.exists(dir_to_check):
                    create_backup(entry=dir_to_check, backup_path=backup_dir)
        else:
            backup_path = os.path.join(HOME, "dotfiles_backup")
            dir_to_check = os.path.join(HOME, entry)

            if os.path.exists(dir_to_check):
                create_backup(entry=dir_to_check, backup_path=backup_path)
    print()


def stow_symlink(package: str, stow_directory: str):
    print(f"Setup: {package}")

    result = subprocess.run(
        [
            "stow",
            "-t",
            HOME,
            "-d",
            stow_directory,
            package,
            "-v",
        ]
    )

    if result.returncode != 0:
        print("Stow setup failed.")
        sys.exit(1)


def remove_symlinks(stow_directory: str, stow_packages: list):
    for entry in os.listdir(stow_directory):
        if os.path.isdir(os.path.join(stow_directory, entry)) and (entry in stow_packages):
            print(f"Removing stow symlinks for package {entry}")

            result = subprocess.run(
                [
                    "stow",
                    "-t",
                    HOME,
                    "-d",
                    stow_directory,
                    "-D",
                    entry,
                    "-v",
                ]
            )

            if result.returncode != 0:
                print("Failed to remove stow symlinks...")
                sys.exit(1)
        else:
            print(f"`{stow_directory}{entry}` is not a stow package listed in the package profile!")


def setup(stow_directory: str, stow_packages: list):
    for entry in os.listdir(stow_directory):
        if os.path.isdir(os.path.join(stow_directory, entry)) and (entry in stow_packages):
            package = entry

            backup(package, stow_directory)
            stow_symlink(package, stow_directory)

            print("\n---\n")
        else:
            print(f"`{stow_directory}{entry}` is not a stow package listed in the package profile!")


def main():
    stow_profiles = {
        "all": [
            "alacritty",
            "assets",
            "awesome",
            "dwm",
            "home_scripts",
            "hypr",
            "kitty",
            "konsole",
            "matugen",
            "nvim",
            "picom",
            "qtile",
            "utility",
        ],
        "dwm": [
            "assets",
            "dwm",
            "home_scripts",
            "kitty",
            "konsole",
            "matugen",
            "nvim",
            "picom",
            "utility",
        ],
        "hyprland": [
            "assets",
            "home_scripts",
            "hypr",
            "kitty",
            "konsole",
            "matugen",
            "nvim",
            "utility",
        ],
        "hyprland_only": [
            "hypr",
        ],
    }

    stow_profiles_available = [profile_pack for profile_pack in stow_profiles.keys()]

    parser = argparse.ArgumentParser(
        description="Manage stow symlinks and backups for your dotfiles."
    )
    parser.add_argument(
        "action",
        help="Action to perform: 'setup' to set up symlinks, 'remove' to remove them.",
        choices=["setup", "remove"],
    )
    parser.add_argument(
        "-s",
        "--stow_directory",
        help="specify the directory containing stow packages",
        required=True,
    )
    parser.add_argument(
        "-p",
        "--package_profile",
        help="specify the stow package profile",
        choices=stow_profiles_available,
    )

    args = parser.parse_args()

    if not args.package_profile:
        stow_profile_choosen = "all"
    else:
        stow_profile_choosen = args.package_profile

    if args.action == "setup":
        setup(
            args.stow_directory,
            stow_packages=stow_profiles[stow_profile_choosen],
        )
    elif args.action == "remove":
        remove_symlinks(
            args.stow_directory,
            stow_packages=stow_profiles[stow_profile_choosen],
        )
    else:
        parser.print_help()
        sys.exit(1)


if __name__ == "__main__":
    main()
