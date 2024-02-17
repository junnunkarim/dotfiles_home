#!/bin/sh

# define ANSI escape codes for custom colors (everforest)
white='\033[38;5;231m'   # #d3c6aa
black='\033[38;5;235m'   # #272e33
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
  printc "$1" $white
}

printn() {
  printc "$1" $white "n"
}

# arguments:
#   a directory name (stow module name)
# returns:
#   none
stow_symlink() {
  local module="$1"

  stow -t ~ "$module" -v
  stow_exit_status=$?

  if [ "$stow_exit_status" -eq 0 ]; then
    echo
    # echo "Completed setting-up stow symlinks..."
  else
    echo
    echo "Stow setup failed."
    exit 1
  fi
}

usage() {
  if [ "$1" = 0 ] || [ "$1" = "error" ]; then
      printc " Usage:" $orange "n"
      printc "\t$0 [option]" $yellow "n"
      echo

      printc " Options:" $orange "n"
      printc "\tsetup\t setup symlinks using stow" $yellow "n"
      printc "\tremove\t remove symlinks created by stow" $yellow "n"
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

        if [ -L "$HOME/.config/$dir_name" ]; then
          printc "\`$dir_name\`" $red
          print " is a symlink in "
          printc "~/.config/" $orange "n"

          print "Removing symlink of "
          printc "~/.config/$dir_name/" $orange "n"

          rm "$HOME/.config/$dir_name"

          sleep 0.5
          stow_symlink "$dir_name"

        elif [ -d "$HOME/.config/$dir_name" ]; then
          print "Directory "
          printc "\`$dir_name\`" $red
          printn " exists in ~/.config/ . Taking backup..."

          print "Moving "
          printc "~/.config/$dir_name/" $orange
          print " to "
          printc "~/.config/dotfiles_backup/" $orange

          mkdir -p "$HOME/.config/dotfiles_backup"
          cp -r "$HOME/.config/$dir_name" "$HOME/.config/dotfiles_backup"

          sleep 0.5
          stow_symlink "$dir_name"

        elif [ "$dir_name" = "assets" ]; then
          if [ -L "$HOME/.config/wallpaper" ]; then
            printc "\`$dir_name\`" $red
            print " is a symlink in "
            printc "~/.config/" $orange "n"

            print "Removing symlink of "
            printc "~/.config/$dir_name/" $orange "n"

            rm "$HOME/.config/$dir_name"

            sleep 0.5
            stow_symlink "$dir_name"

          elif [ -d "$HOME/.config/wallpaper" ]; then
            print "Directory "
            printc "\`wallpaper\`" $red
            printn " exists in ~/.config/ . Taking backup..."

            print "Moving "
            printc "~/.config/wallpaper/" $orange
            print " to "
            printc "~/.config/dotfiles_backup/" $orange

            mkdir -p "$HOME/.config/dotfiles_backup"
            cp -r "$HOME/.config/wallpaper" "$HOME/.config/dotfiles_backup"

            sleep 0.5

          fi

          stow_symlink "$dir_name"
        elif [ "$dir_name" = "home_scripts" ]; then
        else
          print "Directory "
          printc "\`$dir_name\`" $red
          print " does not exist in "
          printc "~/.config/" $orange
          printn ". Skipping backup..."
          echo

          sleep 0.5

        fi
      fi
    done
    ;;
  "remove")
    # remove stow symlinks
    for dir in */; do
      if [ -d "$dir" ]; then
        module=$(basename "$dir")

        stow -t ~ -D "$module" -v
        stow_exit_status=$?

        if [ "$stow_exit_status" != 0]; then
          echo
          printc "Failed to remove stow symlinks..." $red "n"

          exit 1
        fi
      fi
    done
    ;;
  *)
    echo
    printc "Invalid action: $action" $red "n"
    usage "error"
    exit 1
    ;;
esac
