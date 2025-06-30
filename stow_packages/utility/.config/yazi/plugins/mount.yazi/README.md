# mount.yazi

> [!NOTE]
> Yazi v25.2.7 or later is required for this plugin to work.

A mount manager for Yazi, providing disk mount, unmount, and eject functionality.

Supported platforms:

- Linux with [`udisksctl`](https://github.com/storaged-project/udisks) and [`lsblk`](https://github.com/util-linux/util-linux)
- macOS with `diskutil`

https://github.com/user-attachments/assets/c6f780ab-458b-420f-85cf-2fc45fcfe3a2

## Installation

```sh
ya pack -a yazi-rs/plugins:mount
```

## Usage

Add this to your `~/.config/yazi/keymap.toml`:

```toml
[[manager.prepend_keymap]]
on  = "M"
run = "plugin mount"
```

Available keybindings:

| Key binding  | Alternate key | Action                |
| ------------ | ------------- | --------------------- |
| <kbd>q</kbd> | -             | Quit the plugin       |
| <kbd>k</kbd> | <kbd>↑</kbd>  | Move up               |
| <kbd>j</kbd> | <kbd>↓</kbd>  | Move down             |
| <kbd>l</kbd> | <kbd>→</kbd>  | Enter the mount point |
| <kbd>m</kbd> | -             | Mount the partition   |
| <kbd>u</kbd> | -             | Unmount the partition |
| <kbd>e</kbd> | -             | Eject the disk        |

## TODO

- Custom keybindings
- Windows support (I don't have an Windows machine for testing, PRs welcome!)
- Support mount, unmount, and eject the entire disk

## License

This plugin is MIT-licensed. For more information check the [LICENSE](LICENSE) file.
