#!/bin/sh

# Iterate over all automount units
for unit in $(systemctl list-units --type=automount --no-legend | awk '{print $1}'); do
  # Extract the mount path from the unit name
  path=$(systemctl show -p Where --value "$unit")

  # Skip certain system directories
  case "$path" in
  /proc* | /sys* | /dev*) continue ;;
  esac

  # Derive the corresponding .mount unit name from the path
  mount_unit=$(systemd-escape -p --suffix=mount "$path")

  # Check if the .mount unit is active (i.e., the filesystem is mounted)
  if systemctl is-active --quiet "$mount_unit"; then
    continue
  fi

  # If not mounted, log and then access the directory to trigger the automount
  ls "$path" >/dev/null 2>&1 &
done
