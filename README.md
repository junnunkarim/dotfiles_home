<h1 align="center"><i><u>~/dotfiles</u></i></h1>

> [!CAUTION]
>
> <h4>Repo under heavy-reconstruction</h4>

> [!IMPORTANT]
>
> Currently very busy with University.\
> I will update the readme as soon as I get some free time.

# System Information

<h4 align="center">Here are some details about my setup:</h4>

- **OS**: [Arch Linux](https://archlinux.org/)
- **Terminal**: [Kitty](https://github.com/kovidgoyal/kitty) and
  [Konsole](https://konsole.kde.org/)
- **Shell**: [Fish](https://fishshell.com/)
- **Login Manager**: [sddm](https://github.com/sddm/sddm)
- **Editor**: [nvim](https://github.com/neovim/neovim)

---

- **Lock Screen**:
  [betterlockscreen](https://github.com/bakkeby/slock-flexipatch)
- **App Menu**: [rofi](https://github.com/davatorium/rofi)
- **Network Menu**:
  [networkmanager-dmenu](https://github.com/firecat53/networkmanager-dmenu)
- **AUR helper**: [Paru](https://github.com/Morganamilo/paru)
- **Brightness Control**:
  [brightnessctl](https://github.com/Hummer12007/brightnessctl)

---

- **Font**: [Iosevka Nerd Font](https://www.nerdfonts.com/)
- **Shell Prompt**: [starship](https://github.com/starship/starship)
- **System Info**: [macchina](https://github.com/Macchina-CLI/macchina)

---

- **File Manager**: [felix](https://github.com/kyoheiu/felix) and
  [Thunar](https://docs.xfce.org/xfce/thunar/start)
- **Ebook Reader**: [zathura](https://github.com/pwmt/zathura)
- **Image Viewer**: [qView](https://github.com/jurplel/qView)
- **Video Player**: [mpv](https://github.com/mpv-player/mpv)
- **ScreenShot**: [Flameshot](https://github.com/flameshot-org/flameshot)
- **Color Picker**: [Gpick](https://github.com/thezbyg/gpick)
- **Clipboard Manager**: [greenclip](https://github.com/erebe/greenclip)
- **Calculator**: [rofi-calc](https://github.com/svenstaro/rofi-calc)
- **Bookmark Manager**: [buku](https://github.com/jarun/buku)

# Setup

<details>
<summary><h3>Installing Dependencies (Arch Linux)</h3></summary>

> **Under Construction**

</details>

### Automated Setup

<details>
<summary><h4>Setting up with Stow</h4></summary>

> [!WARNING]
>
> **Although the `stow.sh` script has been made to first backup existing dotfile
> directories if they exist, but it has not been intensively tested.**
>
> **So be sure to backup your dotfiles from `$HOME/`, `$HOME/.config/` and
> `$HOME/.local/share/` first.**

> [!IMPORTANT]
>
> **Backup of existing dotfiles produced by the `stow.sh` script will be
> available in the following directories:**
>
> `$HOME/.config/dotfiles_backup/`\
> `$HOME/.local/share/dotfiles_backup/`\
> `$HOME/dotfiles_backup/`

- Clone this repo to your preferred directory and `cd` into the cloned
  directory. (Don't miss the `--recursive` option)

```sh
git clone https://github.com/junnunkarim/dotfiles_home --recursive
cd dotfiles_home
```

- Make the `stow.sh` script executable

```
chmod +x stow.sh
```

- Run the script

```sh
./stow.sh setup
```

</details>

### Manual Setup

> **Under Construction**

# Rices

<details>
<summary><h4>Reveal the rices</h4></summary>

<h3 align="center"><a href="https://github.com/junnunkarim/dotfiles_dwm">dwm</a></h3>
<h3 align="center"><a href="https://github.com/junnunkarim/dotfiles_qtile">Qtile</a></h3>

</details>

# TODO

<details>
<summary><h4>Reveal stuffs that needs to be implemented</h4></summary>

- [x] rewrite `stow.sh` script to python and add options to setup dotfiles for
      specific window manager

</details>
