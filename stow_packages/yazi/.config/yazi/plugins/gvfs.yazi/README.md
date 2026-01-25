# gvfs.yazi

<!-- toc -->

- [Preview](#preview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Note for mounting using fstab](#note-for-mounting-using-fstab)
- [Troubleshooting](#troubleshooting)

<!-- tocstop -->

[gvfs.yazi](https://github.com/boydaihungst/gvfs.yazi) uses [gvfs](https://wiki.gnome.org/Projects/gvfs) and [gio from glib](https://github.com/GNOME/glib) to transparently mount and unmount devices or remote storage in read and write mode,
allowing you to navigate inside, view, and edit individual or groups of files and folders.

Supported protocols: MTP, Hard disk/drive, SMB, SFTP, NFS, GPhoto2 (PTP), FTP, Google Drive (via [GOA](./GNOME_ONLINE_ACCOUNTS_GOA.md)), One drive (via [GOA](./GNOME_ONLINE_ACCOUNTS_GOA.md)), DNS-SD, DAV (WebDAV), AFP, AFC. You need to install corresponding packages to use them.

Tested: MTP, Hard disk/drive (Encrypted and Unencrypted), GPhoto2 (PTP), DAV, SFTP, FTP, SMB, NFSv4, Google Drive, One Drive. You may need to unlock and turn screen on to mount some devices (Android MTP, etc.)

> [!NOTE]
>
> - This plugin only supports Linux

## Preview

https://github.com/user-attachments/assets/6aad98f7-081a-4e06-b398-5f7e8ca4ab39

Google-drive:

https://github.com/user-attachments/assets/fb74a710-5f05-4bf4-b95f-10f40583c5a0

## Features

- Supports all gvfs schemes/protocols (mtp, smb, ftp, sftp, nfs, gphoto2, afp, afc, sshfs, dav, davs, dav+sd, davs+sd, dns-sd)
- Mount hardware device or saved scheme/mount URI (use `--select-then-mount`)
- Auto-jump to mounted location after mount (use `select-then-mount --jump`)
- Unmount and eject hardware devices (use `select-then-unmount --eject`)
- Auto select the first device or saved scheme/mount URI if there is only one listed.
- Jump to mounted location (use `jump-to-device`)
- After jumped to mounted location, jump back to the previous location
  with a single keybind. Make it easier to copy/paste files. (use `jump-back-prev-cwd`)
- Add/Edit/Remove scheme/mount URI (use `add-mount`, `edit-mount`, `remove-mount`). Check this for schemes/mount URI format: [schemes.html](<https://wiki.gnome.org/Projects(2f)gvfs(2f)schemes.html>)
- (Optional) Remember passwords using Keyring or Password Store (need `secret-tool` + `keyring` or `pass` + `gpg` installed)

## Requirements

1. [yazi >= 25.5.31](https://github.com/sxyazi/yazi)

2. This plugin only supports Linux, and requires having [GLib](https://github.com/GNOME/glib), [gvfs](https://gitlab.gnome.org/GNOME/gvfs) (need D-Bus Session)

   ```sh
   # Ubuntu
   sudo apt install gvfs libglib2.0-dev

   # Fedora
   sudo dnf install gvfs gvfs-fuse

   # Arch
   sudo pacman -S gvfs glib2
   ```

3. And other `gvfs` protocol packages, choose what you need, all of them are optional:

   ```sh
   # Ubuntu
   # This included all protocols
   sudo apt install gvfs-backends gvfs-libs

   # Fedora
   sudo dnf install gvfs-afc gvfs-afp gvfs-archive gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb

   # Arch
   sudo pacman -S gvfs-mtp gvfs-afc gvfs-google gvfs-gphoto2 gvfs-nfs gvfs-smb gvfs-afc gvfs-dnssd gvfs-goa gvfs-onedrive gvfs-wsdd
   ```

4. For headless session (non-active console, like connect to a computer via SSH, etc.)
   If you see `GVFS.yazi can only run on DBUS session` error message, please refer to [HEADLESS_WORKAROUND.md](./HEADLESS_WORKAROUND.md) for a workaround.

5. (Optional) Store passwords with Keyring or Password Store (secret-tool + keyring or pass + gpg)
   There are two methods to securely store passwords. Please refer to [SECURE_SAVED_PASSWORD.md](./SECURE_SAVED_PASSWORD.md) for more information.

## Installation

```sh
ya pkg add boydaihungst/gvfs
```

Modify your `~/.config/yazi/init.lua` to include (`setup` function is required):

```lua
require("gvfs"):setup({
  -- (Optional) Allowed keys to select device.
  which_keys = "1234567890qwertyuiopasdfghjklzxcvbnm-=[]\\;',./!@#$%^&*()_+{}|:\"<>?",

  -- (Optional) Table of blacklisted devices. These devices will be ignored in any actions
  -- List of device properties to match, or a string to match the device name:
  -- https://github.com/boydaihungst/gvfs.yazi/blob/master/main.lua#L144
	blacklist_devices = { { name = "Wireless Device", scheme = "mtp" }, { scheme = "file" }, "Device Name"},

  -- (Optional) Save file.
  -- Default: ~/.config/yazi/gvfs.private
  save_path = os.getenv("HOME") .. "/.config/yazi/gvfs.private",

  -- (Optional) Save file for automount devices. Use with `automount-when-cd` action.
  -- Default: ~/.config/yazi/gvfs_automounts.private
  save_path_automounts = os.getenv("HOME") .. "/.config/yazi/gvfs_automounts.private",

  -- (Optional) Input box position.
  -- Default: { "top-center", y = 3, w = 60 },
  -- Position, which is a table:
  -- 	`1`: Origin position, available values: "top-left", "top-center", "top-right",
  -- 	     "bottom-left", "bottom-center", "bottom-right", "center", and "hovered".
  --         "hovered" is the position of hovered file/folder
  -- 	`x`: X offset from the origin position.
  -- 	`y`: Y offset from the origin position.
  -- 	`w`: Width of the input.
  -- 	`h`: Height of the input.
  input_position = { "center", y = 0, w = 60 },

  -- (Optional) Select where to save passwords.
  -- Default: nil
  -- Available options: "keyring", "pass", or nil
  password_vault = "keyring",

  -- (Optional) Only need if you set password_vault = "pass"
  -- Read the guide at SECURE_SAVED_PASSWORD.md to get your key_grip
  key_grip = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",

  -- (Optional) Auto-save password after mount.
  -- Default: false
  save_password_autoconfirm = true,
  -- (Optional) mountpoint of gvfs. Default: /run/user/USER_ID/gvfs
  -- On some system it could be ~/.gvfs
  -- You can't decide this path, it will be created automatically. Only changed if you know where gvfs mountpoint is.
  -- Use command `ps aux | grep gvfs` to search for gvfs process and get the mountpoint path.
  -- root_mountpoint = (os.getenv("XDG_RUNTIME_DIR") or ("/run/user/" .. ya.uid())) .. "/gvfs"
})
```

## Usage

> [!NOTE]
>
> - Moving files to the Trash bin does not work with some protocols (e.g., Android MTP). Please use permanent delete instead.
> - Scheme/Mount URIs shouldn't contain password, because they are saved as plain text in `yazi/config/gvfs.private`.
> - Google Drive, One drive are created via GNOME Online Accounts (GOA).
>   Guide to setup [GNOME_ONLINE_ACCOUNTS_GOA.md](./GNOME_ONLINE_ACCOUNTS_GOA.md)
> - MTP, GPhoto2, AFC, Hard disk/drive, fstab with x-gvfs-show mount option, Google Drive + One drive protocols are listed automatically. So you don't need to add them via `add-mount` command.
>   For other protocols (smb, ftp, sftp, etc), use `add-mount` command to add [Schemes/Mount URI](<https://wiki.gnome.org/Projects(2f)gvfs(2f)schemes.html>).
> - There is a bug in Yazi that prevents mounted folders from refreshing after they are mounted/unmounted.
>   If you encounter this issue, try opening a new tab or moving the cursor up and down to trigger a refresh.
> - Mount Windows bitlocker drives requires bitlocker password to unlock: https://aka.ms/myrecoverykey or https://support.microsoft.com/en-us/windows/find-your-bitlocker-recovery-key-6b71ad27-0b89-ea08-f143-056f5ab347d6

Add this to your `~/.config/yazi/keymap.toml`:

```toml
[mgr]
prepend_keymap = [
    # Mount
    { on = [ "M", "m" ], run = "plugin gvfs -- select-then-mount", desc = "Select device then mount" },
    # or this if you want to jump to mountpoint after mounted
    { on = [ "M", "m" ], run = "plugin gvfs -- select-then-mount --jump", desc = "Select device to mount and jump to its mount point" },

    # This will remount device under current working directory (cwd)
    #   -> cwd = /run/user/1000/gvfs/DEVICE_1/FOLDER_A
    #   -> device mountpoint = /run/user/1000/gvfs/DEVICE_1
    #   -> remount this DEVIEC_1 if needed
    { on = [ "M", "R" ], run = "plugin gvfs -- remount-current-cwd-device", desc = "Remount device under cwd" },

    { on = [ "M", "u" ], run = "plugin gvfs -- select-then-unmount", desc = "Select device then unmount" },
    # Or this if you want to unmount and eject device.
    #   -> Ejected device can safely be removed.
    #   -> Ejecting a device will unmount all paritions/volumes under it.
    #   -> Fallback to normal unmount if not supported by device.
    { on = [ "M", "u" ], run = "plugin gvfs -- select-then-unmount --eject", desc = "Select device then eject" },

    # Also support force unmount/eject.
    #   -> Ignore outstanding file operations when unmounting or ejecting
    { on = [ "M", "U" ], run = "plugin gvfs -- select-then-unmount --eject --force", desc = "Select device then force to eject/unmount" },

    # Add Scheme/Mount URI:
    #   -> Available schemes: mtp, gphoto2, smb, sftp, ftp, nfs, dns-sd, dav, davs, dav+sd, davs+sd, afp, afc, sshfs
    #   -> Read more about the schemes here: https://wiki.gnome.org/Projects(2f)gvfs(2f)schemes.html
    #   -> Explain about the scheme:
    #       -> If it shows like this: {ftp,ftps,ftpis}://[user@]host[:port]
    #       -> All of the value within [] is optional. For values within {}, you must choose exactly one. All others are required.
    #       -> Example: {ftp,ftps,ftpis}://[user@]host[:port] => ip and port: "ftp://myusername@192.168.1.2:9999" or domain: "ftps://myusername@github.com"
    #       -> More examples: smb://user@192.168.1.2/share, smb://WORKGROUP;user@192.168.1.2/share, sftp://user@192.168.1.2/, ftp://192.168.1.2/
    # !WARNING: - Scheme/Mount URI shouldn't contain password.
    #           - Google Drive, One drive are listed automatically via GNOME Online Accounts (GOA). Avoid adding them.
    #           - MTP, GPhoto2, AFC, Hard disk/drive, fstab with x-gvfs-show are also listed automatically. Avoid adding them.
    #           - SSH, SFTP, FTP(s), AFC, DNS_SD now support [/share]. For example: sftp://user@192.168.1.2/home/user_name -> /share = /home/user_name
    #           - ssh:// is alias for sftp://.
    #             -> {sftp,ssh}://[user@]host[:port]. Host can be Host alias in .ssh/config file, ip or domain.
    #             -> For example (home is Host alias in .ssh/config file: Host home):
    #                  -> ssh://user_name@home/home/user_name -> this will mount root path, but jump to subfolder /home/user_name
    #                  -> sftp://user_name@192.168.1.2/home/user_name -> same as above but with ip
    #                  -> sftp://user_name@192.168.1.2:9999/home/user_name -> same as above but with ip and port
    { on = [ "M", "a" ], run = "plugin gvfs -- add-mount", desc = "Add a GVFS mount URI" },

    # Edit a Scheme/Mount URI
    #   -> Will clear saved passwords for that mount URI.
    { on = [ "M", "e" ], run = "plugin gvfs -- edit-mount", desc = "Edit a GVFS mount URI" },

    # Remove a Scheme/Mount URI
    #   -> Will clear saved passwords for that mount URI.
    { on = [ "M", "r" ], run = "plugin gvfs -- remove-mount", desc = "Remove a GVFS mount URI" },

    # Jump
    { on = [ "g", "m" ], run = "plugin gvfs -- jump-to-device", desc = "Select device then jump to its mount point" },
    # If you use `x-systemd.automount` in /etc/fstab or manually added automount unit,
    # then you can use `--automount` argument to auto mount device before jump.
    # Otherwise it won't show up in the jump list.
    { on = [ "g", "m" ], run = "plugin gvfs -- jump-to-device --automount", desc = "Automount then select device to jump to its mount point" },
    { on = [ "`", "`" ], run = "plugin gvfs -- jump-back-prev-cwd", desc = "Jump back to the position before jumped to device" },

    # Automount (This is different from `x-systemd.automount` in /etc/fstab)
    #   -> Hover over any file/folder under a mounted device then run `automount-when-cd` action to enable automount when cd/jump for that device.
    #   -> When you cd/jump to unmounted device mountpoint or its sub folder, this will auto-mount the device before jump.
    #   -> Works with any command or any bookmark plugin that change cwd. For example, use `yamb` to add bookmarks and jump to them, use yazi's built-in `cd` `back` `forward` commands:

    #   -> { on = [ "m", "a" ], run = [ "plugin yamb -- save", "plugin gvfs -- automount-when-cd" ], desc = "Add bookmark and enable automount when cd"}
    { on = [ "M", "t" ], run = "plugin gvfs -- automount-when-cd", desc = "Enable automount when cd to device under cwd" },
    { on = [ "M", "T" ], run = "plugin gvfs -- automount-when-cd --disabled", desc = "Disable automount when cd to device under cwd" },
]
```

It's highly recommended to add these lines to your `~/.config/yazi/yazi.toml`,  
because GVFS is slow that can make yazi freeze when it preloads or previews a large number of files.  
Especially when you use `Google-drive` or `One-drive`.

- Replace `1000` with your real user id (run `id -u` to get user id).
- Replace `USER_NAME` with your real user name (run `whoami` to get username).

> [!IMPORTANT]
>
> For yazi (>=v25.12.29) replace `name` with `url`

```toml
[plugin]
prepend_preloaders = [
  # Do not preload files in mounted locations:
  # Environment variable won't work here.
  # Using absolute path instead.
  { name = "/run/user/1000/gvfs/**/*", run = "noop" },

  # For mounted hard disk/drive
  { name = "/run/media/USER_NAME/**/*", run = "noop" },
]
prepend_previewers = [
  # Allow to preview folder.
  { name = "*/", run = "folder" },

  # Do not previewing files in mounted locations.
  # Uncomment the line below to allow previewing text files.
  # { mime = "{text/*,application/x-subrip}", run = "code" },

  # Using absolute path.
  { name = "/run/user/1000/gvfs/**/*", run = "noop" },

  # For mounted hard disk/drive.
  { name = "/run/media/USER_NAME/**/*", run = "noop" },
]
```

## Note for mounting using fstab

If you are using fstab to mount, you need to add `x-gvfs-show` to the mount options.  
And with it you can only use `jump-to-device` and `jump-back-prev-cwd` actions.

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
  You can manually remount a specific entry with these commands:

  ```sh
  sudo umount /mnt/myshare
  sudo mount -a
  ```

## Troubleshooting

If you have any problems with one of the protocols, please manually mount it using `gio mount Scheme/Mount URI`. See the [list of supported schemes](<https://wiki.gnome.org/Projects(2f)gvfs(2f)schemes.html>).  
Then create an issue ticket and include the output of `gio mount -li` along with the list of mount points under `/run/user/1000/gvfs/` and `/run/media/USERNAME`
