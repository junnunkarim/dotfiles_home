#Ibus settings if needed
#type ibus-setup in terminal to change settings and start the daemon
#delete the hashtags of the next lines and restart
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=dbus
#export QT_IM_MODULE=ibus

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups

export EDITOR='vim'
export VISUAL='nvim'
export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin/:~/.bin"

#PS1="\[\e[0;38;5;203m\]┌\[\e[0;38;5;203m\][\[\e[0;38;5;203m\]\h\[\e[0;38;5;203m\]] \[\e[0;4;38;5;38m\]\w \[\e[0;4;38;5;77m\]\$\[\e[0m\]\n\[\e[0;38;5;203m\]└■|\[\e[0m\]"

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

#list
alias ls='exa --icons'
alias la='exa -a --icons'
alias ll='exa -al'
alias lt='exa -aT'
alias l.="ls -A | egrep '^\.'"

#fix obvious typo's
alias cd..='cd ..'
alias pdw="pwd"
alias udpate='sudo pacman -Syyu'
alias upate='sudo pacman -Syyu'
alias updte='sudo pacman -Syyu'
alias updqte='sudo pacman -Syyu'
alias upqll="yay -Syu --noconfirm"
alias upal="yay -Syu --noconfirm"

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# zellij
alias zl='zellij'

#readable output
alias df='df -h'

#pacman unlock
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias rmpacmanlock="sudo rm /var/lib/pacman/db.lck"

#free
alias free="free -mt"

#continue download
alias wget="wget -c"


# Aliases for software managment
# pacman or pm
alias pacman='sudo pacman --color auto'
alias update='sudo pacman -Syyu'
alias psearch='sudo pacman -Ss'
alias install='sudo pacman -S'
alias pcc='sudo pacman -Sc' #clear package cache
alias pklist='sudo pacman -Qe' #show package list
alias uninstall='sudo pacman -Rcns'

#Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

alias prcc='paru -Scc' #clear paru cache

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# fonts
alias update-fonts='sudo fc-cache -fv'
alias font-search='fc-list | rg'

#quickly kill conkies
alias kc='killall conky'

#hardware info --short
alias hw="hwinfo --short"

#skip integrity check
alias yayskip='yay -S --mflags --skipinteg'
alias trizenskip='trizen -S --skipinteg'

#check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

#get fastest mirrors in your neighborhood
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
#our experimental - best option for the moment
alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias mirrorxx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"

#shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases

#youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-wav="youtube-dl --extract-audio --audio-format wav  "

alias ytv-best="youtube-dl -f bestvideo+bestaudio --external-downloader=aria2c --external-downloader-args --external-downloader=aria2c --external-downloader-args '--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16' "
alias ytv-480="youtube-dl -f 'bestvideo[height=480]+bestaudio' --external-downloader=aria2c --external-downloader-args '--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16' "
alias ytv="youtube-dl --external-downloader=aria2c --external-downloader-args '--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16' "


#search content with ripgrep
alias rg="rg --sort path"

#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

#nano for important configuration files
#know what you do in these files
alias vlightdm="sudo $EDITOR /etc/lightdm/lightdm.conf"
alias vpacman="sudo $EDITOR /etc/pacman.conf"
alias vgrub="sudo $EDITOR /etc/default/grub"
alias vconfgrub="sudo $EDITOR /boot/grub/grub.cfg"
alias vmkinitcpio="sudo $EDITOR /etc/mkinitcpio.conf"
alias vmirrorlist="sudo $EDITOR /etc/pacman.d/mirrorlist"
alias vsddm="sudo $EDITOR /etc/sddm.conf"
alias vfstab="sudo $EDITOR /etc/fstab"
alias vnsswitch="sudo $EDITOR /etc/nsswitch.conf"

alias vsamba="sudo $EDITOR /etc/samba/smb.conf"
alias vbash="$EDITOR ~/.bashrc"
alias vzsh="$EDITOR ~/.zshrc"


#shutdown or reboot
alias shut="sudo shutdown now"
alias re="sudo reboot"

#give the list of all installed desktops - xsessions desktops
alias xd="ls /usr/share/xsessions"

#find the name of the selected program
alias find_name="xprop | grep \"WM_CLASS\""

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
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

#Launch at start
#neofetch
#pfetch
macchina

#pfetch config
#PF_INFO="ascii title os host kernel uptime pkgs memory"

#NNN file manager config
export NNN_PLUG='t:mtpmount;p:preview-tabbed'
export NNN_OPTS="deH"
export NNN_FIFO="/tmp/nnn.fifo"
export LC_COLLATE="C"

export LIBVA_DRIVER_NAME=i965
export VDPAU_DRIVER=va_gl

export GDK_SCALE=1.25

# zoxide
eval "$(zoxide init bash)"

# pywal
#(cat ~/.cache/wal/sequences &)
#source ~/.cache/wal/colors-tty.sh

# starship prompt
eval "$(starship init bash)"

alias ryujinx="AMD_DEBUG=w32ge,w32cs,nohyperz,nofmask glsl_zero_init=true radeonsi_clamp_div_by_zero=true force_integer_tex_nearest=true mesa_glthread=false vblank_mode=0 MESA_NO_ERROR=1 gamemoderun GDK_BACKEND=x11 /home/dragoonfx/.local/share/Ryujinx/Ryujinx"

# intel hardware accelaration
export LIBVA_DRIVER_NAME=iHD
