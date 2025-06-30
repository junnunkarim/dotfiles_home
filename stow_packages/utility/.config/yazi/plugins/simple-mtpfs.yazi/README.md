# simple-mtpfs.yazi

<!--toc:start-->

- [simple-mtpfs.yazi](#simple-mtpfsyazi)
  - [Features](#features)
  - [Requirements](#requirements)
  - [Installation](#installation)
    - [Options](#options)
  - [Usage](#usage)
  <!--toc:end-->

[simple-mtpfs.yazi](https://github.com/boydaihungst/simple-mtpfs.yazi)
uses [simple-mtpfs](https://github.com/phatina/simple-mtpfs/wiki) to
transparently mount and unmount MTP devices in read/write mode, allowing you to
navigate inside, view, and edit individual or groups of files.

[simple-mtpfs.yazi](https://github.com/boydaihungst/simple-mtpfs.yazi) use MTP
and FUSE
to mount MTP devices, like Android, Camera, etc. But because using MTP so it's
way slow
than using other method such as Android adb.

## Features

- Mount and Unmount MTP device, tested with android 14
- Auto select the first device if there is only one device listed.
- Jump to device's mounted location.
- After jumped to device's mounted location, jump back to the previous location
  with a single keybind.
  Make it easier to copy/paste files.
- Auto jump after successfully mounted a device (use `--jump`)

## Requirements

1. A relatively modern (>= 0.4) version of
   [yazi](https://github.com/sxyazi/yazi).

2. This plugin only supports Linux, and requires having
   [simple-mtpfs](https://github.com/phatina/simple-mtpfs/wiki) and [safe-rm (Optional)](https://launchpad.net/safe-rm)
   installed.

## Installation

```sh
ya pack -a boydaihungst/simple-mtpfs
```

Modify your `~/.config/yazi/init.lua` to include:

```lua
require("simple-mtpfs"):setup({})
```

### Options

The plugin supports the following options, which can be assigned during setup:

1. `mount_point`: The folder path will be created to mount. The default value is
   `$HOME/Media`. DO NOT include forward slash (`/`) at the end,
   environment variable won't work (instead use `os.getenv("VARIABLE")`).
2. `mount_opts`: a table of Fuse options after `-o`, get list of them by using
   `simple-mtpfs --help`. The default value is `{"enable-move"}`.

```lua
require("simple-mtpfs"):setup({
  mount_point = os.getenv("HOME") .. "/Android"),
  mount_opts = { "debug", "max_read=1000" }
})
```

## Usage

Add this to your `~/.config/yazi/keymap.toml`:

```toml
[manager]
prepend_keymap = [
    # simple-mtpfs plugin
    { on = [ "M", "m" ], run = "plugin simple-mtpfs -- select-then-mount", desc = "Select device then mount" },
    # or this if you want to jump to mountpoint after mounted
    { on = [ "M", "m" ], run = "plugin simple-mtpfs -- select-then-mount --jump", desc = "Select device to mount and jump to its mount point" },
    # This will remount device under cwd (e.g. cwd = $HOME/Media/1_ZTEV5/Downloads/, device mountpoint = $HOME/Media/1_ZTEV5/)
    { on = [ "M", "r" ], run = "plugin simple-mtpfs -- remount-current-cwd-device", desc = "Remount device under cwd" },
    { on = [ "M", "u" ], run = "plugin simple-mtpfs -- select-then-unmount", desc = "Select device then unmount" },
    { on = [ "g", "m" ], run = "plugin simple-mtpfs -- jump-to-device", desc = "Select device then jump to its mount point" },
    { on = [ "`", "`" ], run = "plugin simple-mtpfs -- jump-back-prev-cwd", desc = "Jump back to the position before jumped to device" },
]
```

It's highly recommended to add these lines to your `~/.config/yazi/yazi.toml`,
because MTP is so slow that makes yazi freeze when it previews a large file,
in that case unplug your MTP device and re-mount. replace `boydaihungst` with your username

```toml
[plugin]
preloaders = [
  # Do not preload MTP mount_point, cause they are very slow.
  # Environment variable won't work here.
  # Using absolute path instead.
  { name = "/home/boydaihungst/Media/**/*", run = "noop" },
  #... the rest of preloaders
]
previewers = [
  # Allow to preview folder.
  { name = "*/", run = "folder", sync = true },
  # Do not preview MTP mount_point (uncomment to except text file)
  #  { mime = "{text/*,application/x-subrip}", run = "code" },
  # Using absolute path.
  { name = "/home/boydaihungst/Media/**/*", run = "noop" },
  #... the rest of previewers
]
```

You can also create udev rules to automounting a device [Udev Rule](https://github.com/phatina/simple-mtpfs/wiki#udev-rule). (Not tested yet)
