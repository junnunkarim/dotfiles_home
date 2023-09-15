local available, telescope = pcall(require, "telescope")
if not available then
  return
end

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

--{{ keymaps
--
vim.keymap.set('n', '<leader>tb', builtin.buffers, {desc = "Show all buffers"})
vim.keymap.set('n', '<leader>td', builtin.diagnostics, {desc = "Show diagnostics"})
vim.keymap.set('n', '<leader>tr', builtin.oldfiles, {desc = "Show recent files"})
vim.keymap.set('n', '<leader>tk', builtin.keymaps, {desc = "Show keymaps"})
vim.keymap.set('n', '<leader>tm', builtin.marks, {desc = "List all marks"})
vim.keymap.set('n', '<leader>tp', builtin.find_files, {desc = "Find project file"})
vim.keymap.set('n', '<leader>tg',
  function()
    builtin.grep_string({ search = vim.fn.input("Grep (Search) > ") });
  end,
  {desc = "Search for pattern"}
)
vim.keymap.set('n', '<leader>ts', builtin.spell_suggest, {desc = "Show spelling"})
vim.keymap.set('n', '<leader>th', builtin.colorscheme, {desc = "Change colorscheme"})
vim.keymap.set('n', '<leader>tf', builtin.treesitter, {desc = "Show variables and function names"})
vim.keymap.set('n', '<leader>ti', builtin.lsp_incoming_calls, {desc = "Show incoming calls of a word"})
--vim.keymap.set('n', '<leader>mn', builtin.man_pages, {desc = "Show manpage"})
--vim.keymap.set('n', '<leader>ps', builtin.live_grep, {desc = "Search for pattern"})
--
-- }}

local options = {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = {
        height = 0.95,
        width = 0.85,
        prompt_position = "bottom",
        preview_height = 0.50,
        preview_cutoff = 0,
      }
    },
    mappings = {
      i = {
        ["<Tab>"] = {
          actions.move_selection_next, type = "action",
          opts = { nowait = true, silent = true }
        },
        ["<S-Tab>"] = {
          actions.move_selection_previous, type = "action",
          opts = { nowait = true, silent = true }
        },
        ["`"] = {
          actions.move_selection_previous, type = "action",
          opts = { nowait = true, silent = true }
        },
      } -- n
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
  } -- extensions
}

telescope.setup(options)
