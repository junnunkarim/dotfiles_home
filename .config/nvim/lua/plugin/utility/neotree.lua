local helper = require("core.helper")

local available, neotree = pcall(require, "neo-tree")

if not available then
  return
end

--{{ keymaps
--
helper.set_keymap("n", "<leader>nn", ":Neotree toggle right<cr>", {noremap = true, silent = true, desc = "Toggle Neo-tree filesystem"})
helper.set_keymap("n", "<leader>nb", ":Neotree toggle buffers float<cr>", {noremap = true, silent = true, desc = "Toggle Neo-tree buffers"})
--
--}}



local options = {
  close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
  open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
  sort_case_insensitive = false, -- used when sorting files and directories in the tree
  window = {
    position = "right",
    width = 30,
    mapping_options = {
      noremap = true,
      nowait = true,
    }, -- mapping_options
    mappings = {
      ["<space>"] = "noop",
      ['fs'] = function() vim.api.nvim_exec('Neotree focus filesystem right', true) end,
      ['bf'] = function() vim.api.nvim_exec('Neotree focus buffers right', true) end,
      ['gt'] = function() vim.api.nvim_exec('Neotree focus git_status right', true) end,
    }, -- mappings
  }, -- window

  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    }, -- filtered_items
    group_empty_dirs = false, -- when true, empty folders will be grouped together
    hijack_netrw_behavior = "open_default",
      -- "open_default" - netrw disabled, opening a directory opens neo-tree
                        -- in whatever position is specified in window.position
      -- "open_current" - netrw disabled, opening a directory opens within the
                        -- window like netrw would, regardless of window.position
      -- "disabled" - netrw left alone, neo-tree does not handle opening dirs
  }, -- filesystem

  buffers = {
    follow_current_file = {
      --enabled = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
      --leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    }, -- follow_current_file
    --group_empty_dirs = true, -- when true, empty folders will be grouped together
    --show_unloaded = true,
  }, -- buffers

} -- options

neotree.setup(options)
