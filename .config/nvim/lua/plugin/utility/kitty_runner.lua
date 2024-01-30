local helper = require("core.helper")

local function get_uuid()
  local uuid_handle = io.popen([[uuidgen]])
  local uuid = uuid_handle:read("*l")
  uuid_handle:close()
  return uuid
end
local uuid = get_uuid()

local available, kitty = pcall(require, "kitty-runner")
if not available then
  return
end

local options = {
  -- name of the kitty terminal:
  runner_name = "kitty-runner-" .. uuid,
  -- kitty arguments when sending lines/command:
  run_cmd = {"send-text", "--"},
  -- kitty arguments when killing a runner:
  kill_cmd = {"close-window"},
  -- use default keymaps:
  use_keymaps = false,
  -- the port used to communicate with the kitty terminal:
  kitty_port = "unix:/tmp/kitty-" .. uuid,
  -- the type of window that kitty will create:
  -- - os-window = a new window
  -- - window = a new split within the current window (see below)
  -- - More info: https://sw.kovidgoyal.net/kitty/glossary/#term-os_window
  mode = "os-window"
}

kitty.setup(options)


--{{ keymaps
--
helper.set_keymap("n", "<leader>kt", "<cmd>KittyOpenRunner<cr>", {silent = true, desc = "Open a new kitty terminal"})
helper.set_keymap("n", "<leader>kp", "<cmd>KittyRunCommand<cr>", {silent = true, desc = "Prompt for a command and send it"})
helper.set_keymap("n", "<leader>kl", "<cmd>KittyReRunCommand<cr>", {silent = true, desc = "Send the last command"})
helper.set_keymap("n", "<leader>kr", "<cmd>KittyOpenRunner<cr>", {silent = true, desc = "Send the line at the current cursor position or the lines of current visual selection"})
helper.set_keymap("x", "<leader>kr", "<cmd>KittyOpenRunner<cr>", {silent = true, desc = "Send the line at the current cursor position or the lines of current visual selection"})
helper.set_keymap("n", "<leader>kc", "<cmd>KittyKillRunner<cr>", {silent = true, desc = "Kill the runner"})
--
--}}
