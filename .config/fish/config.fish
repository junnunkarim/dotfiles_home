if status is-interactive

  #********************************************************************#
  #-------------------------------Exports------------------------------#

  set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin
  set -U fish_user_paths $fish_user_paths $HOME/.local/bin
  set -U fish_user_paths $fish_user_paths $HOME/.bin
  #set -x HISTCONTROL ignoreboth:erasedups
  set -x EDITOR 'nvim'
  set -x VISUAL 'nvim'

  # NNN file manager config
  set -x NNN_PLUG 't:mtpmount;p:preview-tabbed'
  set -x NNN_OPTS "deH"
  set -x NNN_FIFO "/tmp/nnn.fifo"
  set -x LC_COLLATE "C"

  # intel hardware accelaration
  set -x LIBVA_DRIVER_NAME iHD
  #set -x VDPAU_DRIVER va_gl

  # java
  set -x _JAVA_AWT_WM_NONREPARENTING 1
  set -x AWT_TOOLKIT MToolkit

  #________________________________End__________________________________#


  #*********************************************************************#
  #-------------------------All types of Alias--------------------------#

  # fix obvious typo's
  alias cd..='cd ..'
  alias pdw="pwd"
  alias udpate='sudo pacman -Syyu'
  alias upate='sudo pacman -Syyu'
  alias updte='sudo pacman -Syyu'
  alias updqte='sudo pacman -Syyu'

  # exa
  alias ls='exa --icons'
  alias la='exa -a --icons'
  alias ll='exa -al'
  alias lt='exa -aT'

  # fd
  #alias find="fd -p"
  #alias find_all="fd -H -p"

  # top
  alias top='top -E g -e g'

  # skim
  alias find="sk"

  # ripgrep
  alias rg="rg --sort path"

  # xplr
  alias xx="xplr"

  # chezmoi
  alias ch="chezmoi"

  # rm
  alias rm="rm -I"

  # free space
  alias fr="free -h --si"
  alias fs="df --si"

  # nvim
  alias nv="nvim"

  # bpython
  alias pp="bpython"

  # helix
  alias hx="helix"

  # Calcure
  alias calendar="calcure"

  # buku
  alias b="buku --suggest"
  alias b_list="buku -p"

  # translate-shell
  alias dic="trans -d"

  # wezterm
  alias img="wezterm imgcat" # view image in wezterm

  # taskwarrior-tui
  alias ts="taskwarrior-tui"

  # Colorize the grep command output
  alias grep='grep --color=auto'
  alias egrep='egrep --color=auto'
  alias fgrep='fgrep --color=auto'

  # zellij
  alias zl='zellij'

  # telegram
  alias telegram-desktop='XDG_CURRENT_DESKTOP=XFCE telegram-desktop'

  # wget
  alias wget="wget -c" # continue download

  # edit configs
  alias ccnv="nvim ~/.config/nvim/lua/"
  alias ccaw="nvim ~/.config/awesome/."

  # pacman/paru
  alias pacman='sudo pacman --color auto'
  alias update='sudo pacman -Syyu'
  alias psearch='sudo pacman -Ss'
  alias install='sudo pacman -S'
  alias uninstall='sudo pacman -Rcns'
  alias pklist='sudo pacman -Qe' # show package list
  alias pcc='sudo pacman -Sc' # clear package cache
  alias cleanup='sudo pacman -Rns $(pacman -Qtdq)' # cleanup orphaned packages
  alias prcc='paru -Scc' # clear paru cache
  alias prupdate='paru -Sua' # update AUR packages

  # grub
  alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

  # fonts
  alias update-fonts='sudo fc-cache -fv'
  alias font-search='fc-list | rg'

  # conky
  alias kc='killall conky'

  # find the name of the selected program
  alias find_name="xprop | grep \"WM_CLASS\""

  # force scan wifi using nmcli
  alias scan_wifi="nmcli dev wifi rescan && nmcli dev wifi"

  # youtube-dl
  alias youtube-dl="yt-dlp"
  alias yta-aac="youtube-dl --extract-audio --audio-format aac "
  alias yta-best="youtube-dl --extract-audio --audio-format best "
  alias yta-flac="youtube-dl --extract-audio --audio-format flac "
  alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
  alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
  alias yta-wav="youtube-dl --extract-audio --audio-format wav "
  alias ytv="youtube-dl --external-downloader=aria2c --external-downloader-args '--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16' "
  alias ytv-best="youtube-dl -f bestvideo+bestaudio --external-downloader=aria2c --external-downloader-args --external-downloader=aria2c --external-downloader-args '--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16' "
  alias ytv-480="youtube-dl -f 'bestvideo[height=480]+bestaudio' --external-downloader=aria2c --external-downloader-args '--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16' "
  alias ytv-720="youtube-dl -f 'bestvideo[height=720]+bestaudio' --external-downloader=aria2c --external-downloader-args '--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16' "

  # cpu microcode
  alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*' # check vulnerabilities microcode

  # get the fastest mirrors
  alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

  # get the error messages from journalctl
  alias jctl="journalctl -p 3 -xb"

  # list of all installed desktops - xsessions desktops
  alias xd="ls /usr/share/xsessions"

  alias main="cd /mnt/main/"
  alias comp="cd /mnt/main/work/comp_programming/codeforces/"
  alias edu="cd /mnt/main/education/EWU/"
  alias work="cd /mnt/main/work/"
  alias project="cd /mnt/main/work/project"

  #-------------------------End of Alias--------------------------------#
  #________________________________End__________________________________#

  # Launch at start
  macchina
  #neofetch
  #pfetch
  starship init fish | source
end
