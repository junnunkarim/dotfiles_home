require("gvfs"):setup({
	-- (Optional) Allowed keys to select device.
	which_keys = "1234567890qwertyuiopasdfghjklzxcvbnm-=[]\\;',./!@#$%^&*()_+{}|:\"<>?",

	-- (Optional) Table of blacklisted devices. These devices will be ignored in any actions
	-- List of device properties to match, or a string to match the device name:
	-- https://github.com/boydaihungst/gvfs.yazi/blob/master/main.lua#L144
	blacklist_devices = { { name = "Wireless Device", scheme = "mtp" }, { scheme = "file" }, "Device Name" },

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
