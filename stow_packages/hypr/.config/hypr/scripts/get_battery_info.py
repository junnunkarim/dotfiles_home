#!/usr/bin/env python3

import argparse
import subprocess


def get_battery_info(battery_path):
    try:
        battery_percentage = subprocess.run(
            ["cat", f"{battery_path}/capacity"],
            check=True,
            capture_output=True,
            text=True,
        ).stdout.strip()

        battery_status = subprocess.run(
            ["cat", f"{battery_path}/status"],
            check=True,
            capture_output=True,
            text=True,
        ).stdout.strip()

        return int(battery_percentage), battery_status
    except subprocess.CalledProcessError as e:
        raise Exception(f"Failed to read battery information: {e}")
    except ValueError:
        raise Exception("Invalid battery percentage value")


def get_battery_icon(battery_percentage, battery_status):
    # define the battery icons for each 10% segment
    battery_icons = ["󰂃", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰁹"]
    charging_icon = "󰂄"

    # calculate the icon index
    icon_index = battery_percentage // 10

    # if charging, use the charging icon
    if battery_status == "Charging":
        battery_icon = charging_icon
    else:
        # get the corresponding icon
        battery_icon = battery_icons[min(icon_index, len(battery_icons) - 1)]

    return battery_icon


def battery(battery_path: str):
    try:
        battery_percentage, battery_status = get_battery_info(battery_path)
        battery_icon = get_battery_icon(battery_percentage, battery_status)

        # output the battery percentage and icon
        print(f"{battery_percentage}% {battery_icon}")
    except Exception as e:
        print(f"Error: {e}")


def main():
    parser = argparse.ArgumentParser(description="Display battery percentage and icon.")
    parser.add_argument(
        "--battery-path",
        default="/sys/class/power_supply/BAT0",
        help="path to the battery information directory (default: /sys/class/power_supply/BAT0)",
    )

    args = parser.parse_args()

    battery(args.battery_path)


if __name__ == "__main__":
    main()
