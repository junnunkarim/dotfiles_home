#!/bin/bash


# define ANSI escape codes for custom colors (everforest)
white='\033[38;5;231m'  # #d3c6aa
black='\033[38;5;235m'  # #272e33
gray='\033[38;5;242m'   # #859289
red='\033[38;5;203m'    # #e67e80
green='\033[38;5;113m'  # #a7c080
yellow='\033[38;5;223m' # #dbbc7f
blue='\033[38;5;73m'    # #7fbbb3
purple='\033[38;5;176m' # #d699b6
aqua='\033[38;5;71m'    # #83c092
orange='\033[38;5;215m' # #e69875
reset='\033[0m'


# arguments:
#   a string
#   color code
#   "n" meaning, print newline
# returns:
#   none
# outputs:
#   input string with colors
printc() {
  if [ "$3" = "n" ]; then
    # add newline
    echo -e "$2$1$reset"
  else
    # don't add newline
    echo -ne "$2$1$reset"
  fi
}
print() {
  printc "$1" "$white"
}
printn() {
  printc "$1" "$white" "n"
}

usage() {
  if [ "$1" = 0 ] || [ "$1" = "error" ]; then
    printc " Usage:" "$orange" "n"
    printc "\t$0 [option]" "$yellow" "n"
    echo

    printc " Options:" "$orange" "n"
    printc "\tsetup\t setup symlinks using stow" "$yellow" "n"
    printc "\tremove\t remove symlinks created by stow" "$yellow" "n"
    exit 1
  fi
}

# arguments:
#   a directory name (stow module name)
#   path to find the module
# returns:
#   10 if successfull
#   11 if not successfull
take_backup() {
  local dir_name="$1"
  local directory="$2"

  if [ -L "$directory/$dir_name" ]; then
    printc "\`$dir_name\`" "$red"
    print " is a symlink in "
    printc "$directory" "$orange" "n"

    print "Removing symlink of "
    printc "$directory/$dir_name" "$orange" "n"

    rm -v "$directory/$dir_name"

    sleep 0.5

    return 10
  elif [ -d "$directory/$dir_name" ]; then
    print "Directory "
    printc "\`$dir_name\`" "$red"
    printn " exists in $directory/ . Taking backup..."

    print "Moving "
    printc "$directory/$dir_name" "$orange"
    print " to "
    printc "$directory/dotfiles_backup/" "$orange" "n"

    mkdir -p "$directory/dotfiles_backup"

    local timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    local new_dir_name="${dir_name}_${timestamp}"

    mv -vfu "$directory/$dir_name" "$directory/dotfiles_backup/$new_dir_name"

    sleep 0.5

    return 10
  else
    print "Directory "
    printc "\`$dir_name\`" "$red"
    print " does not exist in "
    printc "$directory/" "$orange"
    printn ". Skipping backup..."

    sleep 0.5

    return 11
  fi
}

# arguments:
#   a directory name (stow module name)
# returns:
#   none
stow_symlink() {
  local module="$1"

  stow -t ~ "$module" -v
  stow_exit_status=$?

  if [ "$stow_exit_status" != 0 ]; then
    echo
    echo "Stow setup failed."

    exit 1
  fi
}


# check if the number of arguments is correct
usage $#

# parse the first argument
action="$1"

# perform actions based on the parameter
case "$action" in
"setup")
  for dir in */; do
    if [ -d "$dir" ]; then
      dir_name=$(basename "$dir")


      # TODO: make the directory finding more dynamic
      if [ "$dir_name" = "assets" ]; then
        take_backup "wallpaper" "$HOME/.config"
        echo
        take_backup "fonts" "$HOME/.local/share"
        echo
        take_backup ".themes" "$HOME"
        echo

        stow_symlink "$dir_name"
      elif [ "$dir_name" = "konsole" ]; then
        take_backup "$dir_name" "$HOME/.local/share"

        stow_symlink "$dir_name"
      elif [ "$dir_name" = "home_scripts" ]; then
        take_backup ".bin" "$HOME"

        stow_symlink "$dir_name"
      elif [ "$dir_name" = "utility" ]; then
        take_backup "betterlockscreen" "$HOME/.config"
        echo
        take_backup "btop" "$HOME/.config"
        echo
        take_backup "dmenu" "$HOME/.config"
        echo
        take_backup "felix" "$HOME/.config"
        echo
        take_backup "handlr" "$HOME/.config"
        echo
        take_backup "helix" "$HOME/.config"
        echo
        take_backup "macchina" "$HOME/.config"
        echo
        take_backup "networkmanager-dmenu" "$HOME/.config"
        echo
        take_backup "qBittorrent" "$HOME/.config"
        echo
        take_backup "rofi" "$HOME/.config"
        echo
        take_backup "slock" "$HOME/.config"
        echo
        take_backup "zathura" "$HOME/.config"
        echo

        stow_symlink "$dir_name"
      else
        take_backup "$dir_name" "$HOME/.config"

        stow_symlink "$dir_name"
      fi
    fi

    echo
  done
  ;;
"remove")
  # remove stow symlinks
  for dir in */; do
    if [ -d "$dir" ]; then
      module=$(basename "$dir")

      stow -t ~ -D "$module" -v
      stow_exit_status=$?

      if [ "$stow_exit_status" != 0 ]; then
        echo
        printc "Failed to remove stow symlinks..." "$red" "n"

        exit 1
      fi
    fi
  done
  ;;
*)
  echo
  printc "Invalid action: $action" "$red" "n"
  usage "error"
  exit 1
  ;;
esac
