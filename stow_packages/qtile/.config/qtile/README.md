<h1 align="center"><i><u>Qtile Config</u></i></h1>
<h2 align="center"><i><u>Seriously OUTDATED! Rewrite Needed!</u></i></h2>

> [!CAUTION]
>
> <h4>Rewrite Needed!</h4>

![img](/ss/qtile_unixporn.png)

# System Information

<h4 align="center"><u>Some details about my setup</u></h4>

- OS: [Arch Linux](https://archlinux.org/)
- Terminal: [Kitty](https://github.com/kovidgoyal/kitty)
- Shell: [Fish](https://fishshell.com/)
- WM: [Qtile](https://github.com/qtile/qtile)
- Editor: [nvim](https://github.com/neovim/neovim)

---

- Status Bar: vanilla Qtile bar
- Lock Screen: [betterlockscreen](https://github.com/bakkeby/slock-flexipatch)
- App Menu: [rofi](https://github.com/davatorium/rofi)
- Network Menu: [networkmanager-dmenu](https://github.com/firecat53/networkmanager-dmenu)
- AUR helper: [Paru](https://github.com/Morganamilo/paru)
- Brightness Control: [brightnessctl](https://github.com/Hummer12007/brightnessctl)
- Compositor: [picom](https://github.com/yshui/picom)

---

- Font: [Iosevka Nerd Font](https://www.nerdfonts.com/)

---

- File Manager: [felix](https://github.com/kyoheiu/felix) and [Thunar](https://docs.xfce.org/xfce/thunar/start)
- Ebook Reader: [zathura](https://github.com/pwmt/zathura)
- Image Viewer: [qView](https://github.com/jurplel/qView)
- Video Player: [mpv](https://github.com/mpv-player/mpv)
- ScreenShot: [Flameshot](https://github.com/flameshot-org/flameshot)
- Color Picker: [Gpick](https://github.com/thezbyg/gpick)
- Clipboard Manager: [greenclip](https://github.com/erebe/greenclip)
- Calculator: [rofi-calc](https://github.com/svenstaro/rofi-calc)
- Bookmark Manager: [buku](https://github.com/jarun/buku)

# Dependencies

> **Under-Construction**

# Setup

> **Under-Construction**

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
<summary><b>Reveal those pleasant keybindings</b></summary>

<br>

| **Keybinding (System main)**                               | **Action**                                            |
| ---------------------------------------------------------- | ----------------------------------------------------- |
| <kbd>super</kbd> + <kbd>Return</kbd>                       | Launch terminal                                       |
| <kbd>super</kbd> + <kbd>f</kbd>                            | Toggle fullscreen                                     |
| <kbd>super</kbd> + <kbd>space</kbd>                        | Toggle floating                                       |
| <kbd>super</kbd> + <kbd>b</kbd>                            | Toggle visibility of the bar                          |
| <kbd>super</kbd> + <kbd>Tab</kbd>                          | Cycle through active groups clockwise                 |
| <kbd>super</kbd> + <kbd>grave</kbd>                        | Cycle through active groups anti-clockwise            |
| <kbd>super</kbd> + <kbd>c</kbd>                            | Close/quit focused window                             |
| <kbd>super</kbd> + <kbd>i</kbd>                            | Toggle minimize of focused window                     |
| <kbd>super</kbd> + <kbd>l</kbd>                            | Lock screen                                           |
| <kbd>super</kbd> + <kbd>d</kbd>                            | Open app-launcher                                     |
| <kbd>super</kbd> + <kbd>x</kbd>                            | Open powermenu                                        |
| <kbd>super</kbd> + <kbd>h</kbd>                            | Open clipboard                                        |
| <kbd>super</kbd> + <kbd>r</kbd>                            | Open calculator                                       |
| <kbd>super</kbd> + <kbd>e</kbd>                            | Open emoji-selector                                   |
| <kbd>super</kbd> + <kbd>t</kbd>                            | Open Colorscheme-switcher                             |
| <kbd>super</kbd> + <kbd>n</kbd>                            | Open network manager                                  |
| <kbd>super</kbd> + <kbd>k</kbd>                            | Show keybindings                                      |
| <kbd>super</kbd> + <kbd>1-9</kbd>                          | Switch to specified group                             |
| <kbd>super</kbd> + <kbd>shift</kbd> + <kbd>1-9</kbd>       | Switch to and move focused window to specified group  |
| <kbd>super</kbd> + <kbd>shift</kbd> + <kbd>w</kbd>         | Toggle widgets (extra) visibility                     |
| <kbd>super</kbd> + <kbd>shift</kbd> + <kbd>t</kbd>         | Toggle tray visibility                                |
| <kbd>super</kbd> + <kbd>shift</kbd> + <kbd>r</kbd>         | Reload Qtile config                                   |
| <kbd>super</kbd> + <kbd>shift</kbd> + <kbd>q</kbd>         | Shutdown Qtile                                        |
| <kbd>super</kbd> + <kbd>shift</kbd> + <kbd>b</kbd>         | Open bookmark manager (buku)                          |
| <kbd>super</kbd> + <kbd>shift</kbd> + <kbd>Return</kbd>    | Terminal (dropdown)                                   |
| <kbd>super</kbd> + <kbd>shift</kbd> + <kbd>BackSpace</kbd> | Password manager (dropdown)                           |
| <kbd>super</kbd> + <kbd>shift</kbd> + <kbd>h</kbd>         | Task manager (btop) (dropdown)                        |
| <kbd>alt</kbd> + <kbd>Tab</kbd>                            | Cycle through windows of current group clockwise      |
| <kbd>alt</kbd> + <kbd>grave</kbd>                          | Cycle through windows of current group anti-clockwise |

<br>

| **Keybinding (System low-priority)**                                        | **Action**                         |
| --------------------------------------------------------------------------- | ---------------------------------- |
| <kbd>super</kbd> + <kbd>control</kbd> + <kbd>h</kbd>                        | Grow window to the left            |
| <kbd>super</kbd> + <kbd>control</kbd> + <kbd>l</kbd>                        | Grow window to the right           |
| <kbd>super</kbd> + <kbd>control</kbd> + <kbd>j</kbd>                        | Grow window down                   |
| <kbd>super</kbd> + <kbd>control</kbd> + <kbd>k</kbd>                        | Grow window up                     |
| <kbd>super</kbd> + <kbd>control</kbd> + <kbd>r</kbd>                        | Turn on bluelight filter           |
| <kbd>super</kbd> + <kbd>control</kbd> + <kbd>n</kbd>                        | Turn on bluelight filter           |
| <kbd>super</kbd> + <kbd>control</kbd> + <kbd>v</kbd>                        | Turn on bluelight filter (intense) |
| <kbd>super</kbd> + <kbd>control</kbd> + <kbd>p</kbd>                        | Turn on compositor (picom)         |
| <kbd>super</kbd> + <kbd>control</kbd> + <kbd>u</kbd>                        | Turn off compositor (picom)        |
| <kbd>super</kbd> + <kbd>control</kbd> + <kbd>g</kbd>                        | Open color-picker                  |
| <kbd>super</kbd> + <kbd>control</kbd> + <kbd>shift</kbd> + <kbd>space</kbd> | Cycle between layouts              |

<br>

| **Keybinding (System Keys)**        | **Action**                       |
| ----------------------------------- | -------------------------------- |
| <kbd>super</kbd> + <kbd>F2</kbd>    | Raise brightness                 |
| <kbd>super</kbd> + <kbd>F1</kbd>    | Lower brightness                 |
| <kbd>super</kbd> + <kbd>F5</kbd>    | Lower volume                     |
| <kbd>super</kbd> + <kbd>F6</kbd>    | Raise volume                     |
| <kbd>super</kbd> + <kbd>F7</kbd>    | Mute volume                      |
| <kbd>Print</kbd>                    | Take screenshot                  |
| <kbd>super</kbd> + <kbd>Print</kbd> | Open flameshot (GUI)             |
| <kbd>alt</kbd> + <kbd>Print</kbd>   | Take screenshot after 5 seconds  |
| <kbd>shift</kbd> + <kbd>Print</kbd> | Take screenshot after 10 seconds |

<br>

| **Keybinding (Open Applications)**               | **Action**                    |
| ------------------------------------------------ | ----------------------------- |
| <kbd>super</kbd> + <kbd>alt</kbd> + <kbd>b</kbd> | Open default web browser      |
| <kbd>super</kbd> + <kbd>alt</kbd> + <kbd>e</kbd> | Open Firefox                  |
| <kbd>super</kbd> + <kbd>alt</kbd> + <kbd>t</kbd> | Open file manager (thunar)    |
| <kbd>super</kbd> + <kbd>alt</kbd> + <kbd>f</kbd> | Open TUI file manager (felix) |
| <kbd>super</kbd> + <kbd>alt</kbd> + <kbd>v</kbd> | Open text editor (neovim)     |

<br>

<!-- ![img](/scripts/keymap_ss/mod1.png) -->
<!-- ![img](/scripts/keymap_ss/mod4-control-shift.png) -->
<!-- ![img](/scripts/keymap_ss/mod4-control.png) -->
<!-- ![img](/scripts/keymap_ss/mod4-mod1.png) -->
<!-- ![img](/scripts/keymap_ss/mod4-shift.png) -->
<!-- ![img](/scripts/keymap_ss/mod4.png) -->
<!-- ![img](/scripts/keymap_ss/no_modifier.png) -->
<!-- ![img](/scripts/keymap_ss/shift.png) -->

</details>

# Screenshots

> [!WARNING]
>
> **Overtime the screenshots might get outdated.**  

<details>
<summary><b>Reveal those glorious screenshots</b></summary>

<h3 align="center"><u>Catppuccin</u></h3>

![img](/ss/qtile_catppuccin_1.png)

![img](/ss/qtile_catppuccin_2.png)

![img](/ss/qtile_catppuccin_3.png)


<h3 align="center"><u>Dracula</u></h3>

![img](/ss/qtile_dracula_1.png)

![img](/ss/qtile_dracula_2.png)

![img](/ss/qtile_dracula_3.png)


<h3 align="center"><u>Everforest</u></h3>

![img](/ss/qtile_everforest_1.png)

![img](/ss/qtile_everforest_2.png)

![img](/ss/qtile_everforest_3.png)


<h3 align="center"><u>Gruvbox</u></h3>

![img](/ss/qtile_gruvbox_1.png)

![img](/ss/qtile_gruvbox_2.png)

![img](/ss/qtile_gruvbox_3.png)

<h3 align="center"><u>Nord</u></h3>

![img](/ss/qtile_nord_1.png)

![img](/ss/qtile_nord_2.png)

![img](/ss/qtile_nord_3.png)

<h3 align="center"><u>Rose Pine</u></h3>

![img](/ss/qtile_rose-pine_1.png)

![img](/ss/qtile_rose-pine_2.png)

![img](/ss/qtile_rose-pine_3.png)

</details>

# TODO

<details>
<summary><h4>Reveal stuffs that needs to be implemented</h4></summary>

- [ ] configure dunst

</details>

# Credit

- [knatsakis](https://github.com/knatsakis) for his rofi script to manage bookmarks with buku
