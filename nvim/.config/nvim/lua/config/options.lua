-- neovim options

-----------------------------------------------------------
-- file & backup settings
-----------------------------------------------------------
local file_options = {
  -- disable creation of backup files
  backup = false,
  -- disable swap files
  swapfile = false,
  -- enable persistent undo
  undofile = true,
  -- prevent editing if the file is being changed by another program
  writebackup = true,
  -- file encoding used when writing files
  fileencoding = "utf-8",
}

-----------------------------------------------------------
-- user interface settings
-----------------------------------------------------------
local ui_options = {
  -- use dark background colors
  background = "dark",
  -- enable 24-bit rgb color in the terminal
  termguicolors = true,
  -- height of the command line for messages
  cmdheight = 0,
  -- enable mouse support in all modes
  mouse = "a",
  -- maximum number of items in the popup menu
  pumheight = 10,
  -- don't display the mode (e.g., -- insert --)
  showmode = false,
  -- disable the tabline
  showtabline = 0,
  -- use a global statusline
  laststatus = 3,
  -- always show the sign column to avoid text shifting
  signcolumn = "yes",
  -- this option helps to avoid all the |hit-enter| prompts caused by
  -- fil messages, for example with CTRL-G, and to avoid some other messages.
  shortmess = "ltToOCFsS",
}

-----------------------------------------------------------
-- search & highlight settings
-----------------------------------------------------------
local search_options = {
  -- highlight all matches of previous search pattern
  hlsearch = true,
  -- show match while typing search
  incsearch = true,
  -- ignore case when searching
  ignorecase = true,
  -- enable smart case search (optional; uncomment if needed)
  -- smartcase  = true,
}

-----------------------------------------------------------
-- indentation & tab settings
-----------------------------------------------------------
local indent_options = {
  -- enable smart indentation
  smartindent = true,
  -- convert tabs to spaces
  expandtab = true,
  -- number of spaces to use for each step of (auto)indent
  shiftwidth = 2,
  -- number of spaces that a <tab> counts for
  tabstop = 2,
}

-----------------------------------------------------------
-- window splitting settings
-----------------------------------------------------------
local split_options = {
  -- force horizontal splits to open below current window
  splitbelow = true,
  -- force vertical splits to open to the right of current window
  splitright = true,
}

-----------------------------------------------------------
-- miscellaneous settings
-----------------------------------------------------------
local misc_options = {
  -- reveal markdown syntax (e.g., backticks remain visible)
  conceallevel = 0,
  -- time in milliseconds to wait for a mapped sequence to complete
  timeoutlen = 100,
  -- faster completion by reducing the time to trigger events
  updatetime = 50,
  -- use the system clipboard for copy/paste operations
  clipboard = "unnamedplus",
  -- enable line wrapping
  wrap = true,
  -- break lines at convenient points (do not break words)
  linebreak = true,
  -- highlight column 80 (helpful as a guide)
  colorcolumn = "80",
  -- enable absolute line numbers
  number = true,
  -- enable relative line numbers
  relativenumber = true,
  -- set the width of the number column
  numberwidth = 2,
  -- define characters that form part of a word
  -- 44 -> comma
  -- 46 -> period
  -- 48-57 -> correspond to the digits 0-9
  iskeyword = "_,-,+,=,<,>,(,),{,},[,],\",',:,;,\\,/,#,%,&,*,44,46,48-57",
  cursorline = true,
}

-----------------------------------------------------------
-- merge all option groups into one table
-----------------------------------------------------------
local options = {}

for _, group in ipairs({ file_options, ui_options, search_options, indent_options, split_options, misc_options }) do
  for option, value in pairs(group) do
    options[option] = value
  end
end

-- apply all options
for option, value in pairs(options) do
  vim.opt[option] = value
end

-----------------------------------------------------------
-- additional settings outside the options table
-----------------------------------------------------------

-- remove the '~' symbols from empty lines
vim.opt.fillchars:append({ eob = " " })

-----------------------------------------------------------
-- neovide specific settings
-----------------------------------------------------------
if vim.g.neovide then
  -- set gui font for neovide
  vim.o.guifont = "Iosevka Nerd Font Mono:h18"
  -- neovide scale factor
  vim.g.neovide_scale_factor = 1.0
  -- padding at the top
  vim.g.neovide_padding_top = 10
  -- padding at the bottom (optional)
  vim.g.neovide_padding_bottom = 0
  -- padding on the right
  vim.g.neovide_padding_right = 10
  -- padding on the left
  vim.g.neovide_padding_left = 10
end

-----------------------------------------------------------
-- additional global settings
-----------------------------------------------------------
-- set php lsp to intelephense for lazyvim
--vim.g.lazyvim_php_lsp = "intelephense"
