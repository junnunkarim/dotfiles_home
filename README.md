![img](/ss/dwm_gruvbox_cozy-night.png)

# Information
Here are some details about my setup:
- OS: [Arch Linux](https://archlinux.org/)
- Terminal: [Alacritty](https://github.com/alacritty/alacritty)
- Shell: [Bash](https://www.gnu.org/software/bash/)
- WM: [dwm-flexipatch](https://github.com/bakkeby/dwm-flexipatch)
- Login Manager: [ly](https://github.com/fairyglade/ly)
- Editor: [Vim](https://github.com/vim/vim)
---
- Status Bar: vanilla dwm bar
- Status Content: [luastatus](https://github.com/shdown/luastatus)
- Lock Screen: [slock-flexipatch](https://github.com/bakkeby/slock-flexipatch)
- App Menu: [dmenu-flexipatch](https://github.com/bakkeby/dmenu-flexipatch)
- Network Menu: [networkmanager-dmenu](https://github.com/firecat53/networkmanager-dmenu)
- Dropdown Menu: [tdrop](https://github.com/noctuid/tdrop)
- Hotkey Daemon: [sxhkd](https://github.com/baskerville/sxhkd)
- Notification Daemon: [Linux Notification Center](https://github.com/phuhl/linux_notification_center)
- AUR helper: [Paru](https://github.com/Morganamilo/paru)
- Power Management: [Xfce Power Manger](https://docs.xfce.org/xfce/xfce4-power-manager/start)
- Brightness Control: [brightnessctl](https://github.com/Hummer12007/brightnessctl)
- Compositor: [Picom](https://github.com/yshui/picom)
---
- Font: [Iosevka Nerd Font](https://www.nerdfonts.com/)
- Shell Prompt: [starship](https://github.com/starship/starship)
- System Info: [macchina](https://github.com/Macchina-CLI/macchina)
---
- File Manager: [nnn](https://github.com/jarun/nnn) and [Thunar](https://docs.xfce.org/xfce/thunar/start)
- Ebook Reader: [zathura](https://github.com/pwmt/zathura)
- Image Viewer: [nsxiv](https://github.com/nsxiv/nsxiv)
- Video Player: [mpv](https://github.com/mpv-player/mpv)
- ScreenShot: [Flameshot](https://github.com/flameshot-org/flameshot)
- Wallpaper Setter: [feh](https://github.com/derf/feh)
- Color Picker: [Gpick](https://github.com/thezbyg/gpick)

# TODO
- [x] Switch to [xrdb patch](https://dwm.suckless.org/patches/xrdb/) for theme switching
- [x] Fix the issue with hardcoded path
- [x] Create a list of keybindings
- [ ] Explain installation procedure and how everything works
	- [x] Mention the mandatory and optional dependencies
	- [x] Make a detailed guide for archlinux
	- [ ] Make guides for fedora and debian
- [ ] Redo setup on an updated version of dwm-flexipatch
- [ ] Explain the features of this setup
- [ ] Switch to rofi from dmenu (but keep dmenu as an alternative)
- [ ] Make new colorschemes
- [ ] Rice Firefox or switch to vieb
- [ ] Create conky and eww widgets
- [ ] Remove unused patches
- [ ] Give credit to proper persons and projects

# Dependencies

<details>
<summary><b>Mandatory</b></summary>

- Xorg
- xrdb (for reloading xresource colorschemes)
- imlib2
- alacritty
- dmenu (for opening programs, showing keybindings, changing theme and using as power menu)
- [luastatus](https://github.com/shdown/luastatus) (for status info)
- [sxhkd](https://github.com/baskerville/sxhkd) (for shortcuts)
- [brightnessctl](https://github.com/Hummer12007/brightnessctl)
- [feh](https://github.com/derf/feh) (for setting wallpaper)
- font: Iosevka Nerd Font
	- You can also use any other nerd font, but don't forget to add that font to ```*fonts[]``` in ```config.def.h``` and recompile dwm)

</details>

<details>
<summary><b>Optional</b></summary>

You may choose not to install any of these and but doing so might make some things not work as intended
- Terminal: Alacritty (__main__) and  Kitty (__dropdown__)
	- if you use kitty as your main terminal, replace ```kitty``` to ```Alacritty``` in this line -  ```RULE(.class = "kitty", .isfloating = 1)``` and replace ```Alacritty``` to ```kitty``` in this line - ```RULE(.class = "Alacritty", .tags = 1 << 0, .switchtag = 1)``` in ```config.def.h```
	- if you use any other terminal then you have to modify ```~/.bin/theme_changer``` in order to make that terminal's colorschemes to change automatically when changing theme
- [Paru](https://github.com/Morganamilo/paru)
- [networkmanager-dmenu](https://github.com/firecat53/networkmanager-dmenu)
- [Xfce Power Manager](https://docs.xfce.org/xfce/xfce4-power-manager/start)
- [picom](https://github.com/yshui/picom)
- [macchina](https://github.com/Macchina-CLI/macchina)

</details>

# Setup 

<details>
<summary><b>Arch Linux or Arch based distro</b></summary>

> Work in Progress!!!
### Mandatory Steps

- First backup your dotfiles from your home directory
- Clone this repo to your preferred directory and cd into it - ```git clone https://github.com/junnunkarim/dotfiles-linux && cd dotfiles-linux```

- Install mandatory dependencies
	- ```sudo pacman -Su --needed base-devel coreutils xorg imlib2 alacritty lua sxhkd brightnessctl feh ttf-iosevka-nerd```
	- Install luastatus
		- ```sudo pacman -Su --needed cmake yajl python-docutils```
		- ```git clone https://github.com/shdown/luastatus && cd luastatus```
		- ```cmake . && make && sudo make install```
- Copy necessary configs -
	- ```cp -rf .bin .Xresources .xsession ~```
	- ```cp -rf .config/alacritty .config/dwm .config/dmenu .config/sxhkd .config/wallpaper ~/.config/```
- Build necessary progarms
	- ```cd ~/.config/dwm && sudo make install```
	- ```cd ~/.config/dmenu && sudo make install```
- Create a desktop entry for dwm
	- ```sudo vim /usr/share/xsessions/dwm.desktop```
	```
	[Desktop Entry]
	Encoding=UTF-8
	Name=dwm
	Comment=the dynamic window manager
	Exec=dwm
	Icon=dwm
	Type=XSession
	```
- Open ```~/.config/sxhkd/sxhkdrc``` and ```~/.config/dwm/config.def.h``` in a text editor and modify the keybindings to your need
- Logout and login to dwm
- After getting into dwm press ```super + t``` and choose any colorscheme (this is to load the wallpaper for the first time)

### Optional steps

> make sure you are inside dotfiles-linux directory
- Install paru (AUR helper)
	- ```git clone https://aur.archlinux.org/paru.git```
	- ```cd paru```
	- ```makepkg -si```
- My ```.bashrc```
	- ```cp .bashrc ~```
	- ```sudo pacman -Su --needed exa starship```
	- ```paru -S --needed macchina```
- My ```.vimrc```
	- ```cp .vimrc ~```
	- install [vim-plug](https://github.com/junegunn/vim-plug)
	- setup [coc-nvim](https://github.com/neoclide/coc.nvim)
- picom
	- ```sudo pacman -Su --needed picom```
- networkmanager-dmenu
	- ```paru -S --needed networkmanager-dmenu-git```
- redshift
	- ```sudo pacman -Su --needed redshift```
- Dropdown terminal
	- ```paru -S --needed kitty tdrop tmux```
	- ```cp -rf .config/kitty ~/.config```
- zathura
	- ```sudo pacman -Su --needed zathura```
	- ```cp -rf .config/zathura ~/.config/```
- slock
	- ```cp -rf .config/slock ~/.config/```
	- ```cd ~/.config/slock && sudo make install```
	- Continue setup using [arch wiki](https://wiki.archlinux.org/title/Slock)

</details>

# Default Keybindings
> __Standards__ <br>
> super + [any key] == system main shortcuts <br>
> super + shift + [any key] == system main shortcuts <br>
> super + ctrl + shift + [any key] == system low priority shortcuts <br>
> super + alt + shift + [any key] == system low priority shortcuts <br>
> alt + [any num or alphabet key] == open applications  <br>
> ctrl + [any num or alpabet key] == open other programs or scripts <br>

<details>
<summary><b>Keybindings that depend on dwm</b></summary>

| __Keybinding__								| __Action__ |
| --- 													| --- |
| super + b											| toggle bar on/off |
| super + s											| switch a window form stack with master |
| super + c											| close a program	|
| super + shift + q							| quit dwm (only if all programs are closed) |
| super + space									| toggle floating on/off |
| super + left/right						| increase/decrease window size |
| super + shift + ctrl + space 	| cycle through all layouts |
| super + tab										| move through open tags clockwise |
| super + backtick							| move through open tags anti-clockwise |
| super + 0 (zero)							| toggle gaps on/of |
| super + shift + i							| hide/unhide window |
| super + shift + r							| restart dwm |
| super + f											| toggle fullscreen |
| super + 0-9										| go to the specified tag |
| super + shift + 0-9						| move selected window to the specified tag |
| alt + tab											| move through window focus clockwise |
| alt + backtick								| move through window focus anti-clockwise |

</details>

<details>
<summary><b>Keybindings that are window manager agnostic (sxhkd)</b></summary>

| __Keybinding__								| __Action__ |
| ---														| --- |
| super + return/enter					| open terminal |
| super + shift + return/enter	| open dropdown terminal |
| super + l											| lock screen |
| super + backspace							| reload sxhkd keybindings |
| super + n											| open network menu |
| super + shift + n							| open/close notification center |
| super + shift + escape				| force kill a program |
| super + t											| open theme switcher |
| super + x											| open powermenu |
| super + k											| show all keybindings |
| super + d											| open dmenu |
| super + a											| open dektop applications selector (dmenu) |
| super + ctrl + r							| turn on bluelight filter (redshift) |
| super + ctrl + e							| turn off bluelight filter (redshift) |
| super + ctrl + p							| open color picker (gpick) |
| super + alt + f								| open file manager (thunar) |
| super + alt + n								| open file manager (nnn) |
| super + alt + b								| open chromium |
| super + alt + e								| open firefox |
| super + alt + e								| open vim |
| super + alt + h								| open bottom |
| prtsc													| take fullscreen screenshot now |
| super + prtsc									| take interective screenshot |
| alt + prtsc										| take fullscreen screenshot after 5 sec |
| ctrl + prtsc									| take fullscreen screenshot after 10 sec |
| super + F1										| increase brightness |
| super + F2										| decrease brightness |
| super + F5										| increase volume |
| super + F6										| decrease volume |
| super + F7										| toggle mute on/off |

</details>

# Active dwm Patches

<details>
<summary><b>click here</b></summary>

- BAR_AWESOMEBAR_PATCH
- BAR_LTSYMBOL_PATCH
- BAR_STATUS_PATCH
- BAR_STATUSBUTTON_PATCH
- BAR_STATUS2D_PATCH
- BAR_SYSTRAY_PATCH
- BAR_UNDERLINETAGS_PATCH 
- BAR_WINICON_PATCH 
- BAR_TITLE_LEFT_PAD_PATCH 
- BAR_BORDER_PATCH 
- BAR_CENTEREDWINDOWNAME_PATCH 
- BAR_EWMHTAGS_PATCH
- BAR_IGNORE_XFT_ERRORS_WHEN_DRAWING_TEXT_PATCH
- BAR_PADDING_VANITYGAPS_PATCH 
- ATTACHBOTTOM_PATCH
- CENTER_PATCH
- COMBO_PATCH 
- COOL_AUTOSTART_PATCH
- CYCLELAYOUTS_PATCH
- FOCUSONNETACTIVE_PATCH
- LOSEFULLSCREEN_PATCH
- NET_CLIENT_LIST_STACKING_PATCH 
- ONLYQUITONEMPTY_PATCH
- RESTARTSIG_PATCH
- SHIFTVIEW_CLIENTS_PATCH 
- STACKER_PATCH 
- SWITCHTAG_PATCH 
- TOGGLEFULLSCREEN_PATCH 
- VANITYGAPS_PATCH 
- XRDB_PATCH
- ZOOMSWAP_PATCH
- BSTACK_LAYOUT
- DECK_LAYOUT 
- FIBONACCI_DWINDLE_LAYOUT
- HORIZGRID_LAYOUT
- TILE_LAYOUT
- MONOCLE_LAYOUT

</details>
