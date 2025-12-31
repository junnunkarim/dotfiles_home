# gvfs.yazi

<!--toc:start-->

- [gvfs.yazi](#gvfsyazi)
  - [Preview](#preview)
  - [Features](#features)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Note for mounting using fstab](#note-for-mounting-using-fstab)
  <!--toc:end-->

[gvfs.yazi](https://github.com/boydaihungst/gvfs.yazi) uses [gvfs](https://wiki.gnome.org/Projects/gvfs) and [gio from glib](https://github.com/GNOME/glib) to transparently mount and unmount devices in read/write mode,
allowing you to navigate inside, view, and edit individual or groups of files.

Supported protocols: MTP, Hard disk/drive, SMB, SFTP, NFS, GPhoto2 (PTP), FTP, Google Drive (via [GOA](./GNOME_ONLINE_ACCOUNTS_GOA.md)), One drive (via [GOA](./GNOME_ONLINE_ACCOUNTS_GOA.md)), DNS-SD, DAV (WebDAV), AFP, AFC.
You need to install corresponding packages to use them.

Tested: MTP, Hard disk/drive (Encrypted and Unencrypted), GPhoto2 (PTP), DAV, SFTP, FTP, SMB, NFSv4, Google Drive, One Drive. You may need to unlock and turn screen on to mount some devices (Android MTP, etc.)

By default, `mount` will automatically shows devices which have one of these protocals (MTP, GPhoto2, AFC, Hard disk/drive, google drive, one drive, fstab with x-gvfs-show) or list of added mount URIs.
For other protocols (smb, ftp, sftp, etc), use `add-mount` action with [Schemes URI format](<https://wiki.gnome.org/Projects(2f)gvfs(2f)schemes.html>).

> [!NOTE]
>
> - This plugin only supports Linux
> - Needs D-bus session to work. For headless session (non-active console like connect to a computer via SSH, etc.) Try this workaround: [HEADLESS_WORKAROUND.md](./HEADLESS_WORKAROUND.md)
> - If you have any problems with one of the protocols, please manually mount the device with `gio mount SCHEMES`. [List of supported schemes](<https://wiki.gnome.org/Projects(2f)gvfs(2f)schemes.html>). Then create an issue ticket with the output of `gio mount -li` and list of the mount paths under `/run/user/1000/gvfs/XYZ` and `/run/media/USERNAME`
> - Put files in Trash bin won't work on some protocols (Android MTP), use permanently delete instead.
> - Scheme/Mount URIs shouldn't contain password, because they are saved as plain text in `yazi/config/gvfs.private`.
> - MTP, GPhoto2, AFC, Hard disk/drive are listed automatically. So you also don't need to add them via `add-mount`
> - Google Drive, One drive are mounted automatically via GNOME Online Accounts (GOA). So you don't need to add them via `add-mount`.
>   Guide to setup [GNOME_ONLINE_ACCOUNTS_GOA.md](./GNOME_ONLINE_ACCOUNTS_GOA.md)

## Preview

https://github.com/user-attachments/assets/6aad98f7-081a-4e06-b398-5f7e8ca4ab39

## Features

- Support all gvfs schemes/protocols (mtp, smb, ftp, sftp, nfs, gphoto2, afp, afc, sshfs, dav, davs, dav+sd, davs+sd, dns-sd)
- Mount hardware device or saved scheme/mount URI (use `--mount`)
- Can unmount and eject hardware device (use `--eject`)
- Auto jump to a device or saved scheme/mount URI mounted location after successfully mounted (use `--jump`)
- Auto select the first device or saved scheme/mount URI if there is only one listed.
- Jump to device or saved scheme/mount URI's mounted location (use `jump-to-device` action)
- After jumped to mounted location, jump back to the previous location
  with a single keybind. Make it easier to copy/paste files. (use `jump-back-prev-cwd`)
- Add/Edit/Remove scheme/mount URI (use `add-mount`, `edit-mount`, `remove-mount`). Check this for schemes/mount URI format: [schemes.html](<https://wiki.gnome.org/Projects(2f)gvfs(2f)schemes.html>)
- (Optional) Remember passwords using Keyring or Password Store (need `secret-tool` + `keyring` or `pass` + `gpg` installed)

> [!NOTE]
> There is a bug with yazi, which prevent mounted folders from refreshing after unmounted.
> If you encounter this issue, try create new tab, or move cursor up and down a little bit for yazi to refresh.

## Requirements

1. [yazi >= 25.5.31](https://github.com/sxyazi/yazi)

2. This plugin only supports Linux, and requires having [GLib](https://github.com/GNOME/glib), [gvfs](https://gitlab.gnome.org/GNOME/gvfs) (need D-Bus Session)

   ```sh
   # Ubuntu
   sudo apt install gvfs libglib2.0-dev

   # Fedora (Not tested, please report if it works)
   sudo dnf install gvfs glib2-devel

   # Arch
   sudo pacman -S gvfs glib2
   ```

3. And other `gvfs` protocol packages, choose what you need, all of them are optional:

   ```sh
   # Ubuntu
   # This included all protocols
   sudo apt install gvfs-backends gvfs-libs

   # Fedora (Not tested, please report if it works)
   sudo dnf install gvfs-mtp gvfs-archive gvfs-goa gvfs-gphoto2 gvfs-smb gvfs-afc gvfs-dnssd

   # Arch
   sudo pacman -S gvfs-mtp gvfs-afc gvfs-google gvfs-gphoto2 gvfs-nfs gvfs-smb gvfs-afc gvfs-dnssd gvfs-goa gvfs-onedrive gvfs-wsdd
   ```

4. For headless session (non-active console, Like connect to a computer via SSH, etc.)
   If you see `GVFS.yazi can only run on DBUS session` error message, please refer to [HEADLESS_WORKAROUND.md](./HEADLESS_WORKAROUND.md) for a workaround.

5. (Optional) Store passwords with Keyring or Password Store (secret-tool + keyring or pass + gpg)
   There are two methods to securely store passwords. Please refer to [SECURE_SAVED_PASSWORD.md](./SECURE_SAVED_PASSWORD.md) for more information.

## Installation

```sh
ya pkg add boydaihungst/gvfs
```

Modify your `~/.config/yazi/init.lua` to include:

```lua
require("gvfs"):setup({
  -- (Optional) Allowed keys to select device.
  which_keys = "1234567890qwertyuiopasdfghjklzxcvbnm-=[]\\;',./!@#$%^&*()_+{}|:\"<>?",

  -- (Optional) Save file.
  -- Default: ~/.config/yazi/gvfs.private
  save_path = os.getenv("HOME") .. "/.config/yazi/gvfs.private",

  -- (Optional) input position. Default: { "top-center", y = 3, w = 60 },
  -- Position, which is a table:
  -- 	`1`: Origin position, available values: "top-left", "top-center", "top-right",
  -- 	     "bottom-left", "bottom-center", "bottom-right", "center", and "hovered".
  --         "hovered" is the position of hovered file/folder
  -- 	`x`: X offset from the origin position.
  -- 	`y`: Y offset from the origin position.
  -- 	`w`: Width of the input.
  -- 	`h`: Height of the input.
  input_position = { "center", y = 0, w = 60 },

  -- (Optional) Select where to save passwords. Default: nil
  -- Available options: "keyring", "pass", or nil
  password_vault = "keyring",

  -- (Optional) Only need if you set password_vault = "pass"
  -- Read the guide at SECURE_SAVED_PASSWORD.md to get your key_grip
  key_grip = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",

  -- (Optional) save password automatically after mounting. Default: false
  save_password_autoconfirm = true,
  -- (Optional) mountpoint of gvfs. Default: /run/user/USER_ID/gvfs
  -- On some system it could be ~/.gvfs
  -- You can't choose this path, it will be created automatically, Only changed if you know where gvfs mountpoint is.
  -- root_mountpoint = (os.getenv("XDG_RUNTIME_DIR") or ("/run/user/" .. ya.uid())) .. "/gvfs"
})
```

## Usage

Add this to your `~/.config/yazi/keymap.toml`:

```toml
[mgr]
prepend_keymap = [
    # gvfs plugin
    { on = [ "M", "m" ], run = "plugin gvfs -- select-then-mount", desc = "Select device then mount" },
    # or this if you want to jump to mountpoint after mounted
    { on = [ "M", "m" ], run = "plugin gvfs -- select-then-mount --jump", desc = "Select device to mount and jump to its mount point" },
    # This will remount device under cwd (e.g. cwd = /run/user/1000/gvfs/DEVICE_1/FOLDER_A, device mountpoint = /run/user/1000/gvfs/DEVICE_1)
    { on = [ "M", "R" ], run = "plugin gvfs -- remount-current-cwd-device", desc = "Remount device under cwd" },
    { on = [ "M", "u" ], run = "plugin gvfs -- select-then-unmount", desc = "Select device then unmount" },
    # or this if you want to unmount and eject device. Ejected device can safely be removed.
    # Ejecting a device will unmount all paritions/volumes under it.
    # Fallback to normal unmount if not supported by device.
    { on = [ "M", "u" ], run = "plugin gvfs -- select-then-unmount --eject", desc = "Select device then eject" },
    # Also support force unmount/eject.
    # force = true -> Ignore outstanding file operations when unmounting or ejecting
    { on = [ "M", "U" ], run = "plugin gvfs -- select-then-unmount --eject --force", desc = "Select device then force to eject/unmount" },

    # Add|Edit|Remove mountpoint: smb, sftp, ftp, nfs, dns-sd, dav, davs, dav+sd, davs+sd, afp, afc, sshfs
    # Read more about the schemes here: https://wiki.gnome.org/Projects(2f)gvfs(2f)schemes.html
    # For example: smb://user@192.168.1.2/share, smb://WORKGROUP;user@192.168.1.2/share, sftp://user@192.168.1.2/, ftp://192.168.1.2/
    # - Scheme/Mount URIs shouldn't contain password.
    # - Google Drive, One drive are mounted automatically via GNOME Online Accounts (GOA). Avoid adding them. Use GOA instead: ./GNOME_ONLINE_ACCOUNTS_GOA.md
    # - MTP, GPhoto2, AFC, Hard disk/drive are listed automatically. Avoid adding them
    { on = [ "M", "a" ], run = "plugin gvfs -- add-mount", desc = "Add a GVFS mount URI" },
    # Edit or remove a GVFS mount URI will clear saved passwords for that mount URI.
    { on = [ "M", "e" ], run = "plugin gvfs -- edit-mount", desc = "Edit a GVFS mount URI" },
    { on = [ "M", "r" ], run = "plugin gvfs -- remove-mount", desc = "Remove a GVFS mount URI" },

    # Jump
    { on = [ "g", "m" ], run = "plugin gvfs -- jump-to-device", desc = "Select device then jump to its mount point" },
    # If you use `x-systemd.automount` in /etc/fstab or manually added automount unit, you can use `--automount` to automount device automatically
    { on = [ "g", "m" ], run = "plugin gvfs -- jump-to-device --automount", desc = "Automount then select device to jump to its mount point" },
    { on = [ "`", "`" ], run = "plugin gvfs -- jump-back-prev-cwd", desc = "Jump back to the position before jumped to device" },
]
```

It's highly recommended to add these lines to your `~/.config/yazi/yazi.toml`,
because GVFS is slow that can make yazi freeze when it preloads or previews a large number of files.
Replace `1000` with your real user id (run `id -u` to get user id).
Replace `USER_NAME` with your real user name (run `whoami` to get username).

> [!IMPORTANT]
>
> For yazi nightly replace `name` with `url`

```toml
[plugin]
prepend_preloaders = [
  # Do not preload files in mounted locations:
  # Environment variable won't work here.
  # Using absolute path instead.
  { name = "/run/user/1000/gvfs/**/*", run = "noop" },

  # For mounted location for hard disk/drive
  { name = "/run/media/USER_NAME/**/*", run = "noop" },
  #... the rest of preloaders
]
prepend_previewers = [
  # Allow to preview folder.
  { name = "*/", run = "folder", sync = true },
  # Do not previewing files in mounted locations (uncomment to except text file):
  # { mime = "{text/*,application/x-subrip}", run = "code" },
  # Using absolute path.
  { name = "/run/user/1000/gvfs/**/*", run = "noop" },

  # For mounted hard disk.
  { name = "/run/media/USER_NAME/**/*", run = "noop" },
  #... the rest of previewers
]
```

## Note for mounting using fstab

If you are using fstab to mount, you need to add `x-gvfs-show` to the mount options. And with it you can only use `jump-to-device` and `jump-back-prev-cwd` actions.

- Example `/etc/fstab`:

  - Mount on demand (manually mount):

    ```
    192.168.1.10/hdd  /mnt/myshare  cifs  noauto,credentials=/etc/samba/credentials,x-gvfs-show,iocharset=utf8,uid=1000,gid=1000,file_mode=0660,dir_mode=0770,nofail  0 0
    UUID=XXXX-XXXX  /mnt/myshare2  exfat  noauto,defaults,x-gvfs-show  0 0
    ```

  - Mount on access, add `x-systemd-automount` to the mount options:

    Use `jump-to-device --automount`.
    This will auto mount all mount entries that have `x-systemd-automount`, before jump to.

  - Mount at boot, remove `noauto` from the mount options

  Reload fstab:

  ```sh
  sudo systemctl daemon-reload && sudo systemctl restart local-fs.target && sudo mount -a
  ```

  If you changed mount options (like uid=, gid=, umask=, exfat, ntfs, etc.), already-mounted filesystems won't update unless you unmount and remount them.
  You can manually remount a specific entry using:

  ```sh
  sudo umount /mnt/myshare
  ```

  And then:

  ```sh
  sudo mount -a
  ```
