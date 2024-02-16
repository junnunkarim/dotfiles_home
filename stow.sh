#!/bin/sh

# check if the number of arguments is correct
if [ $# -eq 0 ]; then
    echo "Usage: $0 <setup|remove>"
    exit 1
fi

# parse the first argument
action="$1"

# perform actions based on the parameter
case "$action" in
  "setup")
    if stow -t ~ alacritty assets awesome dwm home_scripts hypr kitty konsole nvim picom qtile utility waybar -v; then
      echo
      echo "Completed setting-up stow symlinks..."
    else
      echo
      echo "Stow setup failed."
      exit 1
    fi
    ;;
  "remove")
    # remove stow symlinks
    if stow -t ~ -D alacritty assets awesome dwm home_scripts hypr kitty konsole nvim picom qtile utility waybar -v; then
      echo
      echo "Completed removing stow symlinks..."
    else
      echo
      echo "Failed to remove stow symlinks..."
      exit 1
    fi
    ;;
  *)
    echo
    echo "Invalid action: $action"
    echo "Usage: $0 <setup|remove>"
    exit 1
    ;;
esac
