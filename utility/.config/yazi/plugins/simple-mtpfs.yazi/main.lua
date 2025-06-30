--- @since 25.2.7

local shell = os.getenv("SHELL") or ""
local home = os.getenv("HOME") or ""
local PLUGIN_NAME = "simple-mtpfs"

---@enum NOTIFY_MSG
local NOTIFY_MSG = {
	MOUNT_SUCCESS = "Mounted device %s at location %s",
	MOUNT_ERROR = "Error: %s",
	UNMOUNT_ERROR = "Device is busy",
	UNMOUNT_SUCCESS = "Unmounted device %s at location %s",
	LIST_DEVICES_EMPTY = "No devices found.",
	DEVICE_IS_DISCONNECTED = "Device is disconnected",
	CANT_ACCESS_PREV_CWD = "Device is disconnected or Previous dir is removed",
}

---@class (exact) Device
---@field number integer
---@field name string

---@enum DEVICE_CONNECT_STATUS
local DEVICE_CONNECT_STATUS = {
	MOUNTED = 1,
	NOT_MOUNTED = 2,
}

---@enum STATE_KEY
local STATE_KEY = {
	PREV_CWD = "PREV_CWD",
	ROOT_MNT_POINT = "ROOT_MNT_POINT",
	MNT_OPTS = "MNT_OPTS",
}

---@enum STATE_STORE_KEY
local STATE_STORE_KEY = {
	GLOBAL = "GLOBAL",
}

---@enum ACTION
local ACTION = {
	SELECT_THEN_MOUNT = "select-then-mount",
	JUMP_TO_DEVICE = "jump-to-device",
	JUMP_BACK_PREV_CWD = "jump-back-prev-cwd",
	SELECT_THEN_UNMOUNT = "select-then-unmount",
	REMOUNT_KEEP_CWD_UNCHANGED = "remount-current-cwd-device",
}

---@enum Command.PIPED
---@enum Command.NULL
---@enum Command.INHERIT

---@type Command
local Command = _G.Command

---@class (exact) Command
---@overload fun(cmd: string): self
---@field PIPED Command.PIPED
---@field NULL Command.NULL
---@field INHERIT Command.INHERIT
---@field arg fun(self: Command, arg: string): self
---@field args fun(self: Command, args: string[]): self
---@field cwd fun(self: Command, dir: string): self
---@field env fun(self: Command, key: string, value: string): self
---@field stdin fun(self: Command, cfg: Command.PIPED | Command.NULL | Command.INHERIT| STD_STREAM): self
---@field stdout fun(self: Command, cfg: Command.PIPED | Command.NULL | Command.INHERIT| STD_STREAM): self
---@field stderr fun(self: Command, cfg: Command.PIPED | Command.NULL | Command.INHERIT| STD_STREAM): self
---@field spawn fun(self: Command): Child|nil, unknown
---@field output fun(self: Command): Output|nil, unknown
---@field status fun(self: Command): Status|nil, unknown

---@alias STD_STREAM unknown

---@class (exact) Child
---@field read fun(self: Child, len: string): string, 1|0
---@field read_line fun(self: Child): string, 1|0
---@field read_line_with fun(self: Child, opts: {timeout: integer}): string, 1|2|3
---@field wait fun(self: Child): Status|nil, unknown
---@field wait_with_output fun(self: Child): Output|nil, unknown
---@field start_kill fun(self: Child): boolean, unknown
---@field take_stdin fun(self: Child): STD_STREAM|nil, unknown
---@field take_stdout fun(self: Child): STD_STREAM|nil, unknown
---@field take_stderr fun(self: Child): STD_STREAM|nil, unknown
---@field write_all fun(self: Child, src: string): STD_STREAM|nil, unknown
---@field flush fun(self: Child): STD_STREAM|nil, unknown

---@class (exact) Output The Output of the command if successful; otherwise, nil
---@field status Status The Status of the child process
---@field stdout string The stdout of the child process, which is a string
---@field stderr string The stderr of the child process, which is a string

---@class (exact) Status The Status of the child process
---@field success boolean whether the child process exited successfully, which is a boolean.
---@field code integer the exit code of the child process, which is an integer if any

local function error(s, ...)
	ya.notify({ title = PLUGIN_NAME, content = string.format(s, ...), timeout = 3, level = "error" })
end

local function info(s, ...)
	ya.notify({ title = PLUGIN_NAME, content = string.format(s, ...), timeout = 3, level = "info" })
end

local set_state = ya.sync(function(state, archive, key, value)
	if state[archive] then
		state[archive][key] = value
	else
		state[archive] = {}
		state[archive][key] = value
	end
end)

local get_state = ya.sync(function(state, archive, key)
	if key then
		return state[archive] and state[archive][key] or nil
	else
		return state[archive] or nil
	end
end)

local function path_quote(path)
	local result = "'" .. string.gsub(path, "'", "'\\''") .. "'"
	return result
end

local current_dir = ya.sync(function()
	return tostring(cx.active.current.cwd)
end)

---run any command
---@param cmd string
---@param args string[]
---@param _stdin? STD_STREAM|nil
---@return integer|nil, Output|nil
local function run_command(cmd, args, _stdin)
	local cwd = current_dir()
	local stdin = _stdin or Command.INHERIT
	local child, cmd_err =
		Command(cmd):args(args):cwd(cwd):stdin(stdin):stdout(Command.PIPED):stderr(Command.PIPED):spawn()

	if not child then
		error("Failed to start `%s` with error: `%s`", cmd, cmd_err)
		return cmd_err, nil
	end

	local output, out_err = child:wait_with_output()
	if not output then
		error("Cannot read `%s` output, error: `%s`", cmd, out_err)
		return out_err, nil
	else
		return nil, output
	end
end

local is_dir = function(dir_path)
	local cha, err = fs.cha(Url(dir_path))
	return not err and cha and cha.is_dir
end

local is_mounted = function(dir_path)
	local res, _ = Command("mountpoint"):args({ dir_path }):stdout(Command.PIPED):stderr(Command.PIPED):output()
	return res and res.status and res.status.success
end

---Get the mtp mount point
---@param mount_folder string|nil
---@return string|nil
local create_root_mount_point = function(mount_folder)
	local mtp_mount_point = mount_folder or (home .. "/Media")
	local _, _, exit_code = os.execute("mkdir -p " .. path_quote(mtp_mount_point))
	if exit_code ~= 0 then
		error("Cannot create mount point %s, check the permissions", mtp_mount_point)
		return
	end
	return mtp_mount_point
end

---Create mount point for device
---@param mount_full_path string|nil
---@return boolean
local create_device_mount_point = function(mount_full_path)
	if not mount_full_path then
		return false
	end
	local _, _, exit_code = os.execute("mkdir -p " .. path_quote(mount_full_path))
	return exit_code == 0
end

---Remove mount point for device
---@param mount_full_path string|nil
---@return boolean
local remove_device_mount_point = function(mount_full_path)
	if not mount_full_path then
		return false
	end
	local _, _, exit_code = os.execute("rm -d -- " .. path_quote(mount_full_path))
	return exit_code == 0
end

--- return a string array with unique value
---@param tbl string[]
---@return string[] table with only unique strings
function tbl_unique_strings(tbl)
	local unique_table = {}
	local seen = {}

	for _, str in ipairs(tbl) do
		if not seen[str] then
			seen[str] = true
			table.insert(unique_table, str)
		end
	end

	return unique_table
end

---split string by char
---@param s string
---@return string[]
local function string_to_array(s)
	local array = {}
	for i = 1, #s do
		table.insert(array, s:sub(i, i))
	end
	return array
end

---
---@param device Device device name path
---@return string
local function get_mount_path(device)
	local mtp_mount_point = get_state(STATE_STORE_KEY.GLOBAL, STATE_KEY.ROOT_MNT_POINT)
	if not mtp_mount_point then
		return ""
	end
	local tmp_path = mtp_mount_point .. "/" .. device.number .. "_" .. device.name
	return tmp_path
end

---mount mtp device
---@param opts {device: Device, mtp_mount_point: string, mount_opts: string[], max_retry?: integer, retries?: integer}
---@return boolean
local function mount_mtp(opts)
	local device = opts.device
	local mtp_mount_point = opts.mtp_mount_point
	local mount_opts = opts.mount_opts
	local max_retry = opts.max_retry or 3
	local retries = opts.retries or 0

	-- already mounted, so stop re-mount
	if is_mounted(opts.mtp_mount_point) then
		return true
	else
		create_device_mount_point(mtp_mount_point)
	end
	-- fuse options
	mount_opts = tbl_unique_strings({ "enable-move", table.unpack(mount_opts or {}) })

	local res, _ = Command(shell)
		:args({
			"-c",
			"simple-mtpfs --device "
				.. tonumber(device.number)
				.. " "
				.. path_quote(mtp_mount_point)
				.. " -o "
				.. table.unpack(mount_opts),
		})
		:stderr(Command.PIPED)
		:stdout(Command.PIPED)
		:output()

	local mount_success = res ~= nil and res.status.success

	if mount_success then
		info(NOTIFY_MSG.MOUNT_SUCCESS, device.name, mtp_mount_point)
		return true
	end

	-- show notification after get max retry
	if retries >= max_retry then
		error(NOTIFY_MSG.MOUNT_ERROR, res and res.stderr or "Unknown")
		return false
	end

	-- Increase retries every run
	retries = retries + 1
	return mount_mtp({
		device = device,
		mtp_mount_point = mtp_mount_point,
		mount_opts = mount_opts,
		retries = retries,
		max_retry = max_retry,
	})
end

--- Return list of connected devices
---@return Device[]
local function list_mtp_device()
	---@type Device[]
	local devices = {}
	local _, res = run_command("simple-mtpfs", { "-l" })
	if res then
		if res.status.success then
			for line in string.gmatch(res.stdout, "[^\r\n]+") do
				local device_number, device_name = line:match("(%d+):%s*(.+)")
				if device_number and device_name then
					table.insert(devices, { number = tonumber(device_number), name = device_name })
				end
			end
		end
	end
	return devices
end

---Return list of mounted devices
---@param status DEVICE_CONNECT_STATUS
---@return Device[]
local function list_mtp_device_by_status(status)
	local devices = list_mtp_device()
	local devices_filtered = {}
	for _, d in ipairs(devices) do
		local mtp_mnt_point = get_mount_path(d)
		local mounted = is_mounted(mtp_mnt_point)
		if status == DEVICE_CONNECT_STATUS.MOUNTED and mounted then
			table.insert(devices_filtered, d)
		end
		if status == DEVICE_CONNECT_STATUS.NOT_MOUNTED and not mounted then
			table.insert(devices_filtered, d)
		end
	end
	return devices_filtered
end

--- Unmount a mtp device
---@param opts {device: Device}
---@return boolean
local function unmount_mtp(opts)
	local mtp_mnt_point = get_mount_path(opts.device)

	local cmd_err, res = run_command("fusermount", { "-u", mtp_mnt_point })
	if cmd_err or (res and not res.status.success) then
		error(NOTIFY_MSG.UNMOUNT_ERROR)
		return false
	end
	if not cmd_err and res and res.status.success then
		info(NOTIFY_MSG.UNMOUNT_SUCCESS, opts.device.name, mtp_mnt_point)
		remove_device_mount_point(mtp_mnt_point)
	end
	return true
end

---show which key to select device from list
---@param devices Device[]
---@return Device|nil
local function select_device_which_key(devices)
	local allow_key_array = string_to_array("1234567890qwertyuiopasdfghjklzxcvbnm-=[]\\;',./!@#$%^&*()_+{}|:\"<>?")
	local which_keys = {}

	for idx, d in ipairs(devices) do
		if idx > #allow_key_array then
			break
		end
		table.insert(which_keys, { on = tostring(allow_key_array[idx]), desc = d.name or "NO_NAME" })
	end

	if #which_keys == 0 then
		return
	end
	local selected_idx = ya.which({
		cands = which_keys,
	})

	if selected_idx and selected_idx > 0 then
		return devices[selected_idx]
	end
end

local function count_yazi_instances()
	local instances = 0
	local cmd_err, res = run_command("pgrep", { "yazi" })
	if res and res.status.success then
		for yazi_instances_pid in string.gmatch(res.stdout, "[^\r\n]+") do
			instances = instances + 1
		end
	end
	return instances
end

local function get_device_from_path(path)
	---@type Device
	local device_within_path
	local mtp_mount_point = get_state(STATE_STORE_KEY.GLOBAL, STATE_KEY.ROOT_MNT_POINT)
	if not mtp_mount_point then
		return device_within_path
	end
	local number, name = string.match(path, mtp_mount_point .. "/(%d+)_(%w+)")
	if number and name then
		device_within_path = {
			number = number,
			name = name,
		}
	end
	return device_within_path
end

---setup function in yazi/init.lua
---@param _ any
---@param opts {mount_point: string|nil, mount_opts: table<string>}
local function setup(_, opts)
	local mount_folder = opts.mount_point
	local mount_opts = opts.mount_opts
	local root_mnt_point = create_root_mount_point(mount_folder)
	if not root_mnt_point then
		return
	end
	set_state(STATE_STORE_KEY.GLOBAL, STATE_KEY.ROOT_MNT_POINT, root_mnt_point)
	set_state(STATE_STORE_KEY.GLOBAL, STATE_KEY.MNT_OPTS, mount_opts)
end

local function jump_to_device_dir_action(selected_device)
	if not selected_device then
		local list_devices = list_mtp_device_by_status(DEVICE_CONNECT_STATUS.MOUNTED)
		selected_device = #list_devices == 1 and list_devices[1] or select_device_which_key(list_devices)
	end
	if not selected_device then
		return
	end
	local mtp_mnt_point = get_mount_path(selected_device)
	local success = is_mounted(mtp_mnt_point)

	if success then
		set_state(STATE_STORE_KEY.GLOBAL, STATE_KEY.PREV_CWD, current_dir())
		ya.manager_emit("cd", { mtp_mnt_point })
	else
		error(NOTIFY_MSG.DEVICE_IS_DISCONNECTED)
	end
end

---
---@param opts {fallback_dir: string?}?
local function jump_to_prev_cwd_action(opts)
	local prev_cwd = get_state(STATE_STORE_KEY.GLOBAL, STATE_KEY.PREV_CWD)
	if not prev_cwd then
		return
	end
	if is_dir(prev_cwd) then
		set_state(STATE_STORE_KEY.GLOBAL, STATE_KEY.PREV_CWD, current_dir())
		ya.manager_emit("cd", { prev_cwd })
	elseif opts and opts.fallback_dir and is_dir(opts.fallback_dir) then
		set_state(STATE_STORE_KEY.GLOBAL, STATE_KEY.PREV_CWD, current_dir())
		ya.manager_emit("cd", { opts.fallback_dir })
	else
		error(NOTIFY_MSG.CANT_ACCESS_PREV_CWD)
	end
end

--- mount action
---@param opts { jump: boolean?, selected_device: Device? }?
local function mount_action(opts)
	local selected_device
	if not opts or not opts.selected_device then
		local list_devices = list_mtp_device_by_status(DEVICE_CONNECT_STATUS.NOT_MOUNTED)
		selected_device = #list_devices == 1 and list_devices[1] or select_device_which_key(list_devices)
		if #list_devices == 0 then
			local list_devices_mounted = list_mtp_device_by_status(DEVICE_CONNECT_STATUS.MOUNTED)
			selected_device = #list_devices_mounted == 1 and list_devices_mounted[1] or nil
			if not selected_device then
				error(NOTIFY_MSG.LIST_DEVICES_EMPTY)
			end
		end
	end
	if opts and opts.selected_device then
		selected_device = opts.selected_device
	end
	if not selected_device then
		return
	end
	local mtp_mnt_point = get_mount_path(selected_device)
	local mount_opts = get_state(STATE_STORE_KEY.GLOBAL, STATE_KEY.MNT_OPTS) or {}

	local success = mount_mtp({
		device = selected_device,
		mtp_mount_point = mtp_mnt_point,
		mount_opts = mount_opts,
	})
	if not success then
		remove_device_mount_point(mtp_mnt_point)
	elseif opts and opts.jump then
		jump_to_device_dir_action(selected_device)
	end
	return success
end

--- unmount action
---@param opts { selected_device: Device? }?
local function unmount_action(opts)
	local selected_device
	if not opts or not opts.selected_device then
		local list_devices = list_mtp_device_by_status(DEVICE_CONNECT_STATUS.MOUNTED)
		selected_device = #list_devices == 1 and list_devices[1] or select_device_which_key(list_devices)
		if not selected_device and #list_devices == 0 then
			error(NOTIFY_MSG.LIST_DEVICES_EMPTY)
		end
	end
	if opts and opts.selected_device then
		selected_device = opts.selected_device
	end
	if not selected_device then
		return
	end

	unmount_mtp({
		device = selected_device,
	})
end

local save_tab_hovered = ya.sync(function()
	local hovered_item_per_tab = {}
	for _, tab in ipairs(cx.tabs) do
		table.insert(hovered_item_per_tab, { id = tab.id, cwd = tostring(tab.current.cwd) })
	end
	return hovered_item_per_tab
end)

local function remount_keep_cwd_unchanged_action()
	local current_tab_device = get_device_from_path(current_dir())
	if not current_tab_device then
		return
	end
	local tabs = save_tab_hovered()
	local saved_tabs = {}
	for _, tab in ipairs(tabs) do
		local tab_device = get_device_from_path(tab.cwd)
		if
			tab_device
			and tab_device.number == current_tab_device.number
			and tab_device.name == current_tab_device.name
		then
			table.insert(saved_tabs, tab)
			ya.manager_emit("cd", { home, tab = tonumber(tab.id) })
		end
	end
	mount_action({ jump = false, selected_device = current_tab_device })
	for _, tab in ipairs(saved_tabs) do
		ya.manager_emit("cd", { tab.cwd, tab = tonumber(tab.id) })
	end
	-- ya.manager_emit("refresh", {})
end

return {
	entry = function(_, job)
		local action = job.args[1]
		local jump = job.args.jump or false
		if not action or not get_state(STATE_STORE_KEY.GLOBAL, STATE_KEY.ROOT_MNT_POINT) then
			return
		end
		-- Select a device then mount
		if action == ACTION.SELECT_THEN_MOUNT then
			mount_action({ jump = jump })
		-- select a device then unmount
		elseif action == ACTION.SELECT_THEN_UNMOUNT then
			unmount_action()
		-- remount device within current cwd
		elseif action == ACTION.REMOUNT_KEEP_CWD_UNCHANGED then
			remount_keep_cwd_unchanged_action()
		-- select a device then go to its mounted point
		elseif action == ACTION.JUMP_TO_DEVICE then
			jump_to_device_dir_action()
		elseif action == ACTION.JUMP_BACK_PREV_CWD then
			jump_to_prev_cwd_action()
		end
	end,
	setup = setup,
}
