# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups
export EDITOR='nvim'
export VISUAL='nvim'
export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin/:~/.bin"

#PS1="\[\e[0;38;5;203m\]┌\[\e[0;38;5;203m\][\[\e[0;38;5;203m\]\h\[\e[0;38;5;203m\]] \[\e[0;4;38;5;38m\]\w \[\e[0;4;38;5;77m\]\$\[\e[0m\]\n\[\e[0;38;5;203m\]└■|\[\e[0m\]"

# ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# increase bash history size
HISTSIZE=10000
HISTFILESIZE=10000


#********************************************************************#
#-------------------------All types of Alias-------------------------#
#____________________________________________________________________#

# fix obvious typo's
alias cd..='cd ..'
alias pdw="pwd"
alias udpate='sudo pacman -Syyu'
alias upate='sudo pacman -Syyu'
alias updte='sudo pacman -Syyu'
alias updqte='sudo pacman -Syyu'

# list
alias ls='exa --icons'
alias la='exa -a --icons'
alias ll='exa -al'
alias lt='exa -aT'

# ripgrep
alias rg="rg --sort path"

# xplr
alias xx="xplr"

# rm
alias rm="rm -I"

# free space
alias fr="free -h --si"
alias fs="df --si"

# nvim
alias nv="nvim"

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

# readable output
alias df='df -h'

# free
alias free="free -mt"

# wget
alias wget="wget -c" # continue download

# pacman/paru
alias pacman='sudo pacman --color auto'
alias update='sudo pacman -Syyu'
alias psearch='sudo pacman -Ss'
alias install='sudo pacman -S'
alias uninstall='sudo pacman -Rcns'
alias pklist='sudo pacman -Qe'  				# show package list
alias pcc='sudo pacman -Sc' 						# clear package cache
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

#find the name of the selected program
alias find_name="xprop | grep \"WM_CLASS\""

# youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv="youtube-dl --external-downloader=aria2c --external-downloader-args '--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16' "
alias ytv-best="youtube-dl -f bestvideo+bestaudio --external-downloader=aria2c --external-downloader-args --external-downloader=aria2c --external-downloader-args '--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16' "
alias ytv-480="youtube-dl -f 'bestvideo[height=480]+bestaudio' --external-downloader=aria2c --external-downloader-args '--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16' "

# cpu microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*' # check vulnerabilities microcode

# get the fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

# get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# list of all installed desktops - xsessions desktops
alias xd="ls /usr/share/xsessions"

#********************************************************************#
#-------------------------END OF SECTION-----------------------------#
#____________________________________________________________________#


## ex = EXtractor for all kinds of archives
## usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Launch at start
#neofetch
#pfetch
macchina

# NNN file manager config
export NNN_PLUG='t:mtpmount;p:preview-tabbed'
export NNN_OPTS="deH"
export NNN_FIFO="/tmp/nnn.fifo"
export LC_COLLATE="C"

# zoxide config
eval "$(zoxide init bash)"

# pywal
#(cat ~/.cache/wal/sequences &)
#source ~/.cache/wal/colors-tty.sh

# starship prompt
eval "$(starship init bash)"

# intel hardware accelaration
export LIBVA_DRIVER_NAME=iHD
#export VDPAU_DRIVER=va_gl

# nvm (node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
