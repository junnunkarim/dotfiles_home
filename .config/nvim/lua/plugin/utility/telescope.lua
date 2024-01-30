local available, telescope = pcall(require, "telescope")
if not available then
  return
end

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

local options = {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = {
        height = 0.95,
        width = 0.85,
        prompt_position = "bottom",
        preview_height = 0.45,
        preview_cutoff = 0,
      }
    },
    mappings = {
      i = {
        ["<Tab>"] = {
          actions.move_selection_previous, type = "action",
          opts = { nowait = true, silent = true }
        },
        ["<S-Tab>"] = {
          actions.move_selection_next, type = "action",
          opts = { nowait = true, silent = true }
        },
        ["`"] = {
          actions.move_selection_next, type = "action",
          opts = { nowait = true, silent = true }
        },
        ['<c-d>'] = actions.delete_buffer,
        ['<a-d>'] = actions.delete_buffer,
      }, -- i
      n = {
        ['<c-d>'] = actions.delete_buffer,
        ['<a-d>'] = actions.delete_buffer,
      }
    } -- mappings
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  }, -- pickers
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    ["ui-select"] = {
      layout_strategy = "cursor",
      layout_config = {
        height = 8,
      },
      border = true,
      previewer = false,
      shorten_path = false,
    },
  } -- extensions
}

telescope.setup(options)

--telescope.load_extension("ui-select")

--{{ keymaps
--
vim.keymap.set(
  'n',
  '<leader>tb',
  "<cmd>Telescope buffers sort_lastused=true<cr>",
  {desc = "All active buffers"}
)
vim.keymap.set(
  'n',
  '<leader>ld',
  "<cmd>Telescope lsp_definitions jump_type=never<cr>",
  {desc = "Definition of the selected word"}
)
vim.keymap.set(
  'n',
  '<leader>lt',
  "<cmd>Telescope lsp_type_definitions jump_type=never<cr>",
  {desc = "Type definition of the selected word"}
)
vim.keymap.set(
  'n',
  '<leader>li',
  "<cmd>Telescope lsp_implementations jump_type=never<cr>",
  {desc = "Implementation of the selected word"}
)
vim.keymap.set(
  'n',
  '<leader>ls',
  "<cmd>Telescope lsp_document_symbols show_line=true<cr>",
  --builtin.treesitter,
  {desc = "Outline of current document"}
)
vim.keymap.set(
  'n',
  '<leader>lr',
  "<cmd>Telescope lsp_references show_line=true<cr>",
  --builtin.lsp_references,
  {desc = "References of the selected word"}
)
vim.keymap.set(
  'n',
  '<leader>de',
  ":Telescope diagnostics bufnr=0 show_line=true<cr>",
  {desc = "Document diagnostics"}
)
vim.keymap.set(
  'n',
  '<leader>dw',
  ":Telescope diagnostics show_line=true<cr>",
  {desc = "Workspace diagnostics"}
)
vim.keymap.set(
  'n',
  '<leader>to',
  builtin.oldfiles,
  {desc = "Recent files"}
)
vim.keymap.set(
  'n',
  '<leader>tk',
  builtin.keymaps,
  {desc = "Keymaps (all)"}
)
vim.keymap.set(
  'n',
  '<leader>tc',
  builtin.command_history,
  {desc = "Command history"}
)
vim.keymap.set(
  'n',
  '<leader>tp',
  builtin.find_files,
  {desc = "Files from workspace"}
)
vim.keymap.set(
  'n',
  '<leader>ts',
  builtin.spell_suggest,
  {desc = "Spelling suggestions of selected word"}
)
vim.keymap.set(
  'n',
  '<leader>tt',
  builtin.colorscheme,
  {desc = "Change colorscheme"}
)
vim.keymap.set(
  'n',
  '<leader>tg',
  builtin.live_grep,
  {desc = "Search (live) in workspace"}
)
vim.keymap.set(
  'n',
  '<leader>th',
  ":Telescope help_tags<cr>",
  {desc = "Help documents"}
)

local notify_available, notify = pcall(require, "notify")
if notify_available then
  vim.keymap.set(
    'n',
    '<leader>tn',
    "<cmd>Telescope notify theme=dropdown<cr>",
    {desc = "Notification history"}
  )
end
--
-- }}
