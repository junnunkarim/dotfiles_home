local available, builtin = pcall(require, "telescope.builtin")
if not available then
  return
end

local available, telescope = pcall(require, "telescope")
if not available then
  return
end

-- Single key
vim.keymap.set('n', '<leader>b', builtin.buffers, {desc = "Show all buffers"})
vim.keymap.set('n', '<leader>d', builtin.diagnostics, {desc = "Show diagnostics"})

-- Starting with "f"
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {desc = "Show recent files"})

-- Starting with "k"
vim.keymap.set('n', '<leader>km', builtin.keymaps, {desc = "Show keymappings"})

-- Starting with mf"
vim.keymap.set('n', '<leader>mn', builtin.man_pages, {desc = "Show manpage"})
vim.keymap.set('n', '<leader>mk', builtin.marks, {desc = "List all marks"})

-- Starting with "p"
vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = "Find file"})
--vim.keymap.set('n', '<leader>ps', builtin.live_grep, {desc = "Search for pattern"})
vim.keymap.set('n', '<leader>ps',
  function()
    builtin.grep_string({ search = vim.fn.input("Grep (Search) > ") });
  end,
  {desc = "Search for pattern"}
)

-- Starting with "s"
vim.keymap.set('n', '<leader>ss', builtin.spell_suggest, {desc = "Show spelling"})

-- Starting with "t"
vim.keymap.set('n', '<leader>th', builtin.colorscheme, {desc = "Change theme"})
vim.keymap.set('n', '<leader>tr', builtin.treesitter, {desc = "Show function names, variables"})

local options = {
  defaults = {
    -- ...
  },
  pickers = {
    find_files = {
      --theme = "dropdown",
    }
  },
  extensions = {
    -- ...
  }
}

telescope.setup(options)
