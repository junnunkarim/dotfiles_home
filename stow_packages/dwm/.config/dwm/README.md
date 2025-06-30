<h1 align="center"><i><u>~/dotfiles</u></i></h1>
<h2 align="center"><i><u>Rewrite Complete!</u></i></h2>

> [!CAUTION]
>
> <h4>Documentation and Screenshots are OUTDATED!</h4>
> <h4>Need to re-write documentation and upload new screenshots!</h4>

![img](/ss/dwm_gruvbox_cozy-night.png)
![img](/ss/dwm_nord_catppuccin-macchiato.png)

# Information

Here are some details about my setup:

- OS: [Arch Linux](https://archlinux.org/)
- Terminal: [Kitty](https://github.com/kovidgoyal/kitty)
- Shell: [Fish](https://fishshell.com/)
- WM: [dwm-flexipatch](https://github.com/bakkeby/dwm-flexipatch)
- Login Manager: [sddm](https://github.com/sddm/sddm)
- Editor: [nvim](https://github.com/neovim/neovim)

---

- Status Bar: vanilla dwm bar
- Status Content: [luastatus](https://github.com/shdown/luastatus)
- Lock Screen: [slock-flexipatch](https://github.com/bakkeby/slock-flexipatch)
- App Menu: [rofi](https://github.com/davatorium/rofi)
- Network Menu: [networkmanager-dmenu](https://github.com/firecat53/networkmanager-dmenu)
- Dropdown Menu: [tdrop](https://github.com/noctuid/tdrop)
- Notification Daemon: [Linux Notification Center](https://github.com/phuhl/linux_notification_center)
- AUR helper: [Paru](https://github.com/Morganamilo/paru)
- Brightness Control: [brightnessctl](https://github.com/Hummer12007/brightnessctl)
- Compositor: [picom](https://github.com/yshui/picom)

---

- Font: [Iosevka Nerd Font](https://www.nerdfonts.com/)
- Shell Prompt: [starship](https://github.com/starship/starship)
- System Info: [macchina](https://github.com/Macchina-CLI/macchina)

---

- File Manager: [felix](https://github.com/kyoheiu/felix) and [Thunar](https://docs.xfce.org/xfce/thunar/start)
- Ebook Reader: [zathura](https://github.com/pwmt/zathura)
- Image Viewer: [qView](https://github.com/jurplel/qView)
- Video Player: [mpv](https://github.com/mpv-player/mpv)
- ScreenShot: [Flameshot](https://github.com/flameshot-org/flameshot)
- Wallpaper Setter: [feh](https://github.com/derf/feh)
- Color Picker: [Gpick](https://github.com/thezbyg/gpick)
- Clipboard Manager: [greenclip](https://github.com/erebe/greenclip)
- Calculator: [rofi-calc](https://github.com/svenstaro/rofi-calc)

# Dependencies

<details>
<summary><b>Mandatory</b></summary>

- Xorg (for beginners, I recommend installing the whole package)
- xrdb (for reloading xresource colorschemes)
- A terminal emulator
  - if you use anything other than alacritty, modify the line `static const char *termcmd[]  = { "alacritty", NULL };` in `~/.config/dwm/config.h` to your terminal's name (**the theme_changer script will only change the colorschemes of wezterm, alacritty or kitty**)
- rofi (for opening programs, showing keybindings, changing theme, using as power menu, managing clipboard, using as a calculator etc)
- [luastatus](https://github.com/shdown/luastatus) (for status info)
- [feh](https://github.com/derf/feh) (for setting wallpaper)
- Font: Iosevka Nerd Font and Iosevka normal
  - You can also use any other nerd font, but don't forget to add that font to `*fonts[]` in `~/.config/dwm/config.h` and recompile)

</details>

<details>
<summary><b>Optional</b></summary>

You may choose not to install any of these and but doing so might make some things not work as intended

- Drop-down terminal: kitty
  - Drop-down creator - [tdrop](https://github.com/noctuid/tdrop)
  - If you want to use anothera terminal as a drop-down terminal, replace `kitty` to your preferred terminal name in this line - `RULE(.class = "kitty", .isfloating = 1)` in `~/.config/dwm/config.h`
- [Paru](https://github.com/Morganamilo/paru)
- [picom](https://github.com/yshui/picom)
- [networkmanager-dmenu](https://github.com/firecat53/networkmanager-dmenu)
- [brightnessctl](https://github.com/Hummer12007/brightnessctl)
- [starship](https://github.com/starship/starship)
- [macchina](https://github.com/Macchina-CLI/macchina)

</details>

# Setup

<details>
<summary><b>Arch Linux or Arch based distro</b></summary>

> **Work in Progress!!!**

### Mandatory Steps

> [!WARNING]
>
> Backup your dotfiles from your home directory. These steps below will overwrite your configs.**  

> [!WARNING]
>
> This rice only has been on a 1920x1080 resolution display.**

> [!NOTE]
>
> If you want to use my dotfiles then it is highly recommended to fork this repo as I might heavily change it overtime.**
>
> If you don't want to use my configs for programs other than dwm and dmenu, then manually change the `~/.bin/dwm/theme_changer` or else things might get out of control

- Clone this repo to your preferred directory and cd into it - `git clone https://github.com/junnunkarim/dotfiles-linux && cd dotfiles-linux`

- Install mandatory dependencies

```sh
sudo pacman -Su --needed base-devel coreutils xorg alacritty lua feh ttf-iosevka-nerd ttc-iosevka wmctrl
```

- Install luastatus
    - `sudo pacman -Su --needed cmake yajl python-docutils`
    - Follow installation steps from here - [luastatus](https://github.com/shdown/luastatus#installation)

- Copy necessary configs -
  - `cp -rf .bin .Xresources .xinitrc ~`
    - If you won't use my bashrc then add `.bin` to your $PATH variable
    - **Do not copy `.xsession` as it will change your keyboard layout to dvorak.**
  - `cp -rf .config/alacritty .config/dwm .config/rofi .config/wallpaper ~/.config/`

- Build dwm and dmenu

```sh
cd ~/.config/dwm && sudo make install
cd ~/.config/dmenu && sudo make install
```

- Create a desktop entry for dwm

```sh
sudo vim /usr/share/xsessions/dwm.desktop
```

```
[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=the dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
```

- Open `$HOME/.config/dwm/config.h` in a text editor and modify the keybindings to your needs
- Extract the gtk themes from `.themes` directory to your `$HOME/.themes` directory
- Login to dwm using a display manager
  - After getting into dwm press `super + t` and choose any colorscheme (this is to load the wallpaper for the first time)

### Optional steps

> [!WARNING]
>
> **For each options below, make sure that you are in the dotfiles-linux directory**  

- Install paru (AUR helper)
  - `git clone https://aur.archlinux.org/paru.git`
  - `cd paru`
  - `makepkg -si`
- If you want to use my `.bashrc`
  - `cp .bashrc ~`
  - `sudo pacman -Su --needed exa starship`
  - `paru -S --needed macchina`
- If you want to use my `config.fish`
  - `cp -rf ~/.config/fish/config.fish`
  - `sudo pacman -Su --needed exa starship`
  - `paru -S --needed macchina`
- nvim dotfiles
  - `cp -rf .config/nvim ~/.config`
- If you want to use my `.vimrc`
  - `cp .vimrc ~`
  - install [vim-plug](https://github.com/junegunn/vim-plug)
  - setup [coc-nvim](https://github.com/neoclide/coc.nvim)
- brightnessctl
  - `sudo pacman -Su --needed brightnessctl`
- picom
  - `sudo pacman -Su --needed picom`
- networkmanager-dmenu
  - `paru -S --needed networkmanager-dmenu-git`
- redshift
  - `sudo pacman -Su --needed redshift`
- Dropdown terminal
  - `paru -S --needed kitty tdrop tmux`
  - `cp -rf .config/kitty ~/.config`
- zathura
  - `sudo pacman -Su --needed zathura`
  - `cp -rf .config/zathura ~/.config/`
- slock
  - `cp -rf .config/slock ~/.config/`
  - `cd ~/.config/slock && sudo make install`
  - Continue lockscreen setup using [arch wiki - slock](https://wiki.archlinux.org/title/Slock)

</details>

# Default Keybindings

> [!NOTE]
>
> **Standards**  
>
> super + [any key] == system main shortcuts  
> super + shift + [any key] == system main shortcuts  
> super + ctrl + shift + [any key] == system low priority shortcuts  
> super + alt + shift + [any key] == system low priority shortcuts  
> super + alt + [any num or alphabet key] == open applications  
> super + ctrl + [any num or alpabet key] == open other programs or scripts  

<details>
<summary><b>Keybindings</b></summary>

| **Keybinding**               | **Action**                                 |
| ---------------------------- | ------------------------------------------ |
| super + b                    | toggle bar on/off                          |
| super + s                    | switch a window form stack with master     |
| super + c                    | close a program                            |
| super + shift + q            | quit dwm (only if all programs are closed) |
| super + space                | toggle floating on/off                     |
| super + left/right           | increase/decrease window size              |
| super + shift + ctrl + space | cycle through all layouts                  |
| super + tab                  | move through active tags clockwise         |
| super + backtick             | move through active tags anti-clockwise    |
| super + 0 (zero)             | toggle gaps on/of                          |
| super + shift + i            | hide/unhide window                         |
| super + shift + r            | restart dwm                                |
| super + f                    | toggle fullscreen                          |
| super + 0-9                  | go to the specified tag                    |
| super + shift + 0-9          | move selected window to the specified tag  |
| alt + tab                    | move through window focus clockwise        |
| alt + backtick               | move through window focus anti-clockwise   |

| **Keybinding**               | **Action**                              |
| ---------------------------- | --------------------------------------- |
| super + return/enter         | open terminal                           |
| super + shift + return/enter | open dropdown terminal                  |
| super + l                    | lock screen                             |
| super + n                    | open network menu                       |
| super + t                    | open theme switcher                     |
| super + x                    | open powermenu                          |
| super + k                    | show all keybindings                    |
| super + d                    | open rofi                               |
| super + h                    | open clipboad manager (greenclip)       |
| super + r                    | open calculator (rofi-calc)             |
| super + ctrl + r             | turn on bluelight filter (redshift)     |
| super + ctrl + n             | turn off bluelight filter (redshift)    |
| super + ctrl + p             | turn on compositor (picom)              |
| super + ctrl + u             | turn on compositor (picom)              |
| super + ctrl + g             | open color picker (gpick)               |
| super + alt + f              | open file manager (thunar)              |
| super + alt + n              | open file manager (nnn)                 |
| super + alt + b              | open chromium                           |
| super + alt + e              | open firefox                            |
| super + alt + e              | open neovim                             |
| super + alt + h              | open btop                               |
| prtsc                        | take fullscreen screenshot now          |
| super + prtsc                | take interective screenshot             |
| alt + prtsc                  | take fullscreen screenshot after 5 sec  |
| ctrl + prtsc                 | take fullscreen screenshot after 10 sec |
| super + F1                   | increase brightness                     |
| super + F2                   | decrease brightness                     |
| super + F5                   | increase volume                         |
| super + F6                   | decrease volume                         |
| super + F7                   | toggle mute on/off                      |

</details>

# Active dwm Patches

<details>
<summary><b>Show Patches</b></summary>

- BAR_AWESOMEBAR_PATCH
- BAR_LTSYMBOL_PATCH
- BAR_STATUS_PATCH
- BAR_STATUSBUTTON_PATCH
- BAR_STATUS2D_PATCH
- BAR_SYSTRAY_PATCH
- BAR_UNDERLINETAGS_PATCH
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
- FSIGNAL_PATCH
- LOSEFULLSCREEN_PATCH
- NET_CLIENT_LIST_STACKING_PATCH
- ONLYQUITONEMPTY_PATCH
- RESTARTSIG_PATCH
- SHIFTVIEW_CLIENTS_PATCH
- STACKER_PATCH
- SWITCHTAG_PATCH
- TOGGLEFULLSCREEN_PATCH
- VANITYGAPS_PATCH
- VANITYGAPS_MONOCLE_PATCH
- XRDB_PATCH
- ZOOMSWAP_PATCH
- TILE_LAYOUT
- MONOCLE_LAYOUT

</details>

# Screenshots

> [!WARNING]
>
> **Overtime the screenshots might get outdated.**  

<details>
<summary><b>Reveal those glorious screenshots</b></summary>

<h3 align="center"><u>Catppuccin (Macchiato)</u></h3>

![img](/ss/dwm_catppuccin_macchiato_1.png)
![img](/ss/dwm_catppuccin_macchiato_2.png)
![img](/ss/dwm_catppuccin_macchiato_3.png)

<h3 align="center"><u>Cozy-Night</u></h3>

![img](/ss/dwm_cozy-night_1.png)
![img](/ss/dwm_cozy-night_4.png)

<h3 align="center"><u>Dracula</u></h3>

![img](/ss/dwm_dracula_1.png)
![img](/ss/dwm_dracula_2.png)
![img](/ss/dwm_dracula_3.png)

<h3 align="center"><u>Gruvbox</u></h3>

![img](/ss/dwm_gruvbox_1.png)
![img](/ss/dwm_gruvbox_2.png)
![img](/ss/dwm_gruvbox_3.png)

<h3 align="center"><u>Nord</u></h3>

![img](/ss/dwm_nord_1.png)
![img](/ss/dwm_nord_2.png)
![img](/ss/dwm_nord_3.png)

</details>

# r/unixporn

- [[dwm] Well, what do you say?](https://www.reddit.com/r/unixporn/comments/un7we2/dwm_well_what_do_you_say/?utm_source=share&utm_medium=web2x&context=3)
- [[dwm] Hurry! Take your medication, we're going to stargaze at the top of the mountain!](https://www.reddit.com/r/unixporn/comments/vv2ssi/dwm_hurry_take_your_medication_were_going_to/?utm_source=share&utm_medium=web2x&context=3)

# TODO

<details>
<summary><h4>Reveal stuffs that needs to be implemented</h4></summary>

- [x] ~~Switch to [xrdb patch](https://dwm.suckless.org/patches/xrdb/) for theme switching~~
- [x] ~~Fix the issue with hardcoded path~~
- [x] ~~Create a list of keybindings~~
- [x] ~~Explain installation procedure and how everything works~~
  - [x] ~~Mention the mandatory and optional dependencies~~
  - [x] ~~Make a detailed guide for archlinux~~
- [x] ~Redo setup on an updated version of dwm-flexipatch~
- [ ] Explain the features of this setup
- [x] ~Switch to rofi from dmenu (but keep dmenu as an alternative)~
- [ ] Make new colorschemes
  - [x] ~~nord~~
  - [x] ~~dracula~~
  - [x] ~~catppuccin~~
  - [x] ~~rose-pine~~
  - [x] ~~everblush~~
  - [ ] kanagawa
- [ ] Rice Firefox or switch to vieb
- [ ] Create conky and eww widgets
- [ ] Remove unused patches
- [ ] Give credit to proper persons and projects
- [x] ~~Write my own neovim config~~
- [ ] Update the README
- [ ] Update rofi to look like dmenu

</details>

# Credit

- **I do not take any credit for the images I use as wallpaper**. I simply upscaled and changed the colorscheme of some wallpapers to match with my setup. **But all credit goes to the original author**. Since I have been collecting these wallpaper from various sources, for most of the images I do not know who the original author is. So,
  - If you know the name of the author, please let me know. I will surely mention their name in `.config/wallpaper` directory.
  - If you are the artist and you do not want me to redistribute your art, then let me know. I will remove your art from my git repo.
- Name of the image artists that I know are listed [here](/.config/wallpaper/README.md)

- [adi1090x](https://github.com/adi1090x) mainly for his [Archcraft](https://archcraft.io/) and his scripts as well as configs (from where I learned a lot)
- [NvChad](https://github.com/NvChad) for the neovim configs
- [karlivory](https://github.com/karlivory) for fixing the need to restart dwm when changing theme
- [Petingoso](https://github.com/Petingoso) for modifying the theme_changer script to also change gtk theme
