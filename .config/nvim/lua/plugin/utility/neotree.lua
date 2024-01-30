local helper = require("core.helper")

local available, neotree = pcall(require, "neo-tree")

if not available then
  return
end

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

  sources = {
    "filesystem",
    "buffers",
    "git_status",
    --"document_symbols",
    "diagnostics",
  },

  -- source_selector = {
  --   winbar = true,
  --   statusline = false,
  --   sources = {
  --     {
  --       source = "filesystem",
  --       display_name = " 󰉓 "
  --     },
  --     {
  --       source = "buffers",
  --       display_name = " 󰈚 "
  --     },
  --     {
  --       source = "git_status",
  --       display_name = " 󰊢 "
  --     },
  --     {
  --       source = "diagnostics",
  --       display_name = "  "
  --     },
  --   }, -- sources
  -- }, --  source_selector

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
      leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    }, -- follow_current_file
    --group_empty_dirs = true, -- when true, empty folders will be grouped together
    --show_unloaded = true,
  }, -- buffers

  diagnostics = {
    auto_preview = { -- May also be set to `true` or `false`
      enabled = false, -- Whether to automatically enable preview mode
      preview_config = {}, -- Config table to pass to auto preview (for example `{ use_float = true }`)
      event = "neo_tree_buffer_enter", -- The event to enable auto preview upon (for example `"neo_tree_window_after_open"`)
    },
    bind_to_cwd = true,
    diag_sort_function = "severity", -- "severity" means diagnostic items are sorted by severity in addition to their positions.
                                     -- "position" means diagnostic items are sorted strictly by their positions.
                                     -- May also be a function.
    follow_current_file = { -- May also be set to `true` or `false`
      enabled = true, -- This will find and focus the file in the active buffer every time
      always_focus_file = false, -- Focus the followed file, even when focus is currently on a diagnostic item belonging to that file
      expand_followed = true, -- Ensure the node of the followed file is expanded
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      leave_files_open = false, -- `false` closes auto expanded files, such as with `:Neotree reveal`
    },
    group_dirs_and_files = true, -- when true, empty folders and files will be grouped together
    group_empty_dirs = true, -- when true, empty directories will be grouped together
    show_unloaded = true, -- show diagnostics from unloaded buffers
    refresh = {
      delay = 100, -- Time (in ms) to wait before updating diagnostics. Might resolve some issues with Neovim hanging.
      event = "vim_diagnostic_changed", -- Event to use for updating diagnostics (for example `"neo_tree_buffer_enter"`)
                                        -- Set to `false` or `"none"` to disable automatic refreshing
      max_items = 10000, -- The maximum number of diagnostic items to attempt processing
                         -- Set to `false` for no maximum
    },
  }, -- diagnonstics

} -- options

neotree.setup(options)

--{{ keymaps
--
helper.set_keymap("n", "<leader>nn", "<cmd>Neotree toggle right<cr>", {noremap = true, silent = true, desc = "Toggle Neo-tree filesystem"})
helper.set_keymap("n", "<leader>nb", "<cmd>Neotree toggle buffers float<cr>", {noremap = true, silent = true, desc = "Toggle Neo-tree buffers"})
helper.set_keymap("n", "<leader>ng", "<cmd>Neotree toggle git_status float<cr>", {noremap = true, silent = true, desc = "Toggle Neo-tree git-status"})
helper.set_keymap("n", "<leader>nd", "<cmd>Neotree toggle diagnostics float<cr>", {noremap = true, silent = true, desc = "Toggle Neo-tree diagnostics"})
helper.set_keymap("n", "<leader>nr", "<cmd>Neotree reveal<cr>", {noremap = true, silent = true, desc = "Reveal Neo-tree"})
--helper.set_keymap("n", "<leader>no", "<cmd>Neotree toggle document_symbols float<cr>", {noremap = true, silent = true, desc = "Toggle Neo-tree document-symbols"})
--
--}}
