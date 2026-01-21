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
