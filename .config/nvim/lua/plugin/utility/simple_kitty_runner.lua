local helper = require("core.helper")

local available, simple_kitty = pcall(require, "kitty-runner")
if not available then
  return
end

local options = {
  runner = {
    -- default location of runner. Docs: https://sw.kovidgoyal.net/kitty/remote-control/#cmdoption-kitty-launch-location
    default_location = "vsplit",
    -- delay between opening runner and sending command.
    delay = 0,
    -- extra arguments for opening runner, Docs: https://sw.kovidgoyal.net/kitty/remote-control/#id14
    extra_open_runner_args = { "--dont-take-focus" },
    -- extra arguments for sending command to runner, docs: https://sw.kovidgoyal.net/kitty/remote-control/#id22
    extra_send_command_args = {},
    -- environment variables, that will be copy to the runner instance
    env_to_copy = { "PATH" }
  },
  launch = {
    -- default location of launch result. Docs: https://sw.kovidgoyal.net/kitty/remote-control/#cmdoption-kitty-launch-location
    default_location = "vsplit",
    -- extra arguments for launching to runner. Docs: https://sw.kovidgoyal.net/kitty/remote-control/#cmdoption-kitty-launch-location
    extra_launch_args = {},
    -- environment variables, that will be copy to the launcher instance
    env_to_copy = { "PATH" },
  },
    -- socket where kitty is listening. See ssh section
    -- kitty_listen_on = environment_var("KITTY_LISTEN_ON")

}

simple_kitty.setup(options)

--{{ keymaps
--
-- helper.set_keymap("n", "<leader>kt", "<cmd>KittyOpenRunner<cr>", {silent = true, desc = "Open a new kitty terminal"})
-- helper.set_keymap("n", "<leader>kp", "<cmd>KittyRunCommand<cr>", {silent = true, desc = "Prompt for a command and send it"})
-- helper.set_keymap("n", "<leader>kl", "<cmd>KittyReRunCommand<cr>", {silent = true, desc = "Send the last command"})
-- helper.set_keymap("n", "<leader>kr", "<cmd>KittyOpenRunner<cr>", {silent = true, desc = "Send the line at the current cursor position or the lines of current visual selection"})
-- helper.set_keymap("x", "<leader>kr", "<cmd>KittyOpenRunner<cr>", {silent = true, desc = "Send the line at the current cursor position or the lines of current visual selection"})
-- helper.set_keymap("n", "<leader>kc", "<cmd>KittyKillRunner<cr>", {silent = true, desc = "Kill the runner"})
--
--}}
