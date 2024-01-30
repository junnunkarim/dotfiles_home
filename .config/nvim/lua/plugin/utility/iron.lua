local helper = require("core.helper")

local available, iron = pcall(require, "iron.core")

if not available then
  return
end

local options = {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    highlight_last = "IronLastSent",
    --visibility = require("iron.visibility").focus,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = {"fish"}
      },
      python = require("iron.fts.python").ipython
    },
    -- How the repl window will be displayed
    -- See below for more information
    -- repl_open_cmd = require('iron.view').split("40%"),
    repl_open_cmd = "rightbelow 15 split",
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = "<space>is",
    visual_send = "<space>iv",
    send_file = "<space>if",
    send_line = "<space>il",
    send_until_cursor = "<space>iu",
    send_mark = "<space>im",
    --mark_motion = "<space>im",
    mark_visual = "<space>iv",
    remove_mark = "<space>ir",
    -- cr = "<space>s<cr>",
    interrupt = "<space>ic",
    exit = "<space>iq",
    -- clear = "<space>ic",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

iron.setup(options)

--{{ keymaps
--
helper.set_keymap("n", "<leader>ii", "<cmd>IronRepl<cr>", {noremap = true, silent = true, desc = "Open REPL"})
--helper.set_keymap("n", "<leader>ir", "<cmd>IronRestart<cr>", {noremap = true, silent = true, desc = "Restart REPL"})
--helper.set_keymap("n", "<leader>if", "<cmd>IronFocus<cr>", {noremap = true, silent = true, desc = "Focus REPL"})
--helper.set_keymap("n", "<leader>ih", "<cmd>IronHide<cr>", {noremap = true, silent = true, desc = "Hide REPL"})
--
--}}
