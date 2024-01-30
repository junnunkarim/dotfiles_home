if status is-interactive

  function print_center -a width
    set -e argv[1] #Remove width argument
    set -l len (string length -- "$argv")
    if test $len -lt $width
      set -l half (math -s 0 "($width / 2)" + "($len / 2)")
      set -l rem (math -s 0 $width - $half)
      printf "%*.*s%*s\n" $half $len "$argv" $rem ' '
    else
      printf "%*.*s\n" $width $width "$argv"
    end
  end

  #********************************************************************#
  #-------------------------------Exports------------------------------#

  # disable fish startup text
  set -g fish_greeting

  set -l column_len $COLUMNS
  if test $column_len -lt 60
    print_center $COLUMNS '“My Lord increase me in knowledge”'\n
    print_center $COLUMNS '(Surah Ta-Ha:114)'
  else
    print_center $COLUMNS '“Our Lord! Do not punish us if we forget or make a mistake.'\n
    print_center $COLUMNS 'Our Lord! Do not place a burden on us-'
    print_center $COLUMNS '-like the one you placed on those before us.'\n
    print_center $COLUMNS 'Our Lord! Do not burden us with what we cannot bear.'\n
    print_center $COLUMNS 'Pardon us, forgive us, and have mercy on us.'\n
    print_center $COLUMNS 'You are our ˹only˺ Guardian.'\n
    print_center $COLUMNS 'So grant us victory over the disbelieving people.”'\n
    print_center $COLUMNS '(Surah Al-Baqarah - 2:286)'
  end

  set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin
  set -U fish_user_paths $fish_user_paths $HOME/.local/bin
  set -U fish_user_paths $fish_user_paths $HOME/.bin
  set -U fish_user_paths $fish_user_paths $HOME/.bin/zk
  #set -x HISTCONTROL ignoreboth:erasedups
  set -x EDITOR 'nvim'
  set -x VISUAL 'nvim'

  # NNN file manager config
  set -x NNN_PLUG 't:mtpmount;p:preview-tui'
  set -x NNN_OPTS "deH"
  set -x NNN_FIFO "/tmp/nnn.fifo"
  set -x LC_COLLATE "C"

  # intel hardware accelaration
  set -x LIBVA_DRIVER_NAME iHD
  #set -x VDPAU_DRIVER va_gl

  # java
  set -x _JAVA_AWT_WM_NONREPARENTING 1
  set -x AWT_TOOLKIT MToolkit

  # python virtualfish
  # set -x VIRTUALFISH_HOME $HOME/.virtualenvs
  set -x VIRTUALFISH_HOME /mnt/main/.virtualenvs
  #python pyenv
  set -Ux PYENV_ROOT $HOME/.pyenv
  set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
  pyenv init - | source

  # python
  # set -a PYTHONPATH /mnt/main/work/project/python/library/matplotlib-backend-kitty
  # set -x MPLBACKEND "module://matplotlib-backend-kitty"

  # jupyterlab
  set -x JUPYTERLAB_DIR "$HOME/.local/share/jupyter/lab"

  # zk (mickael-menu)
  set -x ZK_NOTEBOOK_DIR "/mnt/main/notebook/"

  # QT theme
  set -x QT_STYLE_OVERRIDE qt5ct
  # set -a QT_QPA_PLATFORMTHEME "qt5ct"

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

  # eza
  alias ls='eza --icons'
  alias la='eza -a --icons'
  alias ll='eza -al'
  alias lt='eza -aT'

  # dust
  alias dust='dust -r'

  # fd
  #alias find="fd -p"
  #alias find_all="fd -H -p"

  # top
  alias top='top -E g -e g'

  # skim
  alias find="sk"

  # lazygit
  alias lg="lazygit"

  # ripgrep
  alias rg="rg --sort path"

  # xplr
  alias xx="xplr"

  # chezmoi
  alias ch="chezmoi"

  # tokei
  alias sloc="tokei"
  alias line_of_code="tokei"

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

  # trashy
  alias ts="trash"
  alias tl="trash list"
  alias tp="trash"

  # wezterm
  alias img="wezterm imgcat" # view image in wezterm

  # kitty
  alias icat="kitty +kitten icat"

  # taskwarrior-tui
  # alias ts="taskwarrior-tui"

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

  # system information fetch
  alias fetch="macchina"

  # edit configs
  alias ccnv="nvim ~/.config/nvim/lua/"
  alias ccaw="nvim ~/.config/awesome/."
  alias ccqt="nvim ~/.config/qtile/."
  alias ccfs="nvim ~/.config/fish/."

  # pacman/paru
  alias pacman='sudo pacman --color auto'
  alias update='sudo pacman -Syyu'
  alias psearch='sudo pacman -Ss'
  alias install='sudo pacman -S'
  alias uninstall='sudo pacman -Rcns'
  alias pklist='sudo pacman -Qe' # show package list
  alias pcc='sudo pacman -Sc' # clear package cache
  alias cleanup='pcc && prcc && sudo pacman -Rns $(pacman -Qtdq)' # cleanup orphaned packages
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

  # yt-dlp
  alias yt-720="yt-dlp -f 'bestvideo[height<=720][ext=mp4]+bestaudio/best[height<=720][ext=m4a]'"

  # cpu microcode
  alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*' # check vulnerabilities microcode

  # get the fastest mirrors
  alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

  # get the error messages from journalctl
  alias jctl="journalctl -p 3 -xb"

  # list of all installed desktops - xsessions desktops
  alias xd="ls /usr/share/xsessions"

  # directory shortcuts
  alias main="cd /mnt/main/"
  alias comp="cd /mnt/main/work/comp_programming/codeforces/"
  alias edu="cd /mnt/main/education/"
  alias ewu="cd /mnt/main/education/EWU/"
  alias work="cd /mnt/main/work/"
  alias project="cd /mnt/main/work/project"
  alias machine_learning="cd /mnt/main/work/project/machine_learning/"

  alias bmn="cd /mnt/main/"
  alias bcp="cd /mnt/main/work/comp_programming/codeforces/"
  alias bpj="cd /mnt/main/work/project"
  alias bml="cd /mnt/main/work/project/machine_learning/"

  # texlive
  alias tlmgr='TEXMFDIST/scripts/texlive/tlmgr.pl --usermode'

  #-------------------------End of Alias--------------------------------#
  #________________________________End__________________________________#

  # Launch at start
  # macchina
  # neofetch
  # pfetch
  # oh-my-posh init fish | source
  starship init fish | source
  # krabby random
end
