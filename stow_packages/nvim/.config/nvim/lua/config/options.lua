-- global
---------
vim.g.health = { style = "float" }

-- stylua: ignore start
--
local opt = vim.opt

-- file & backup
----------------
opt.backup = false -- creation of backup files
opt.swapfile = true -- swap files
opt.undofile = true -- persistent undo
opt.writebackup = true -- make a backup before overwriting a file
opt.fileencoding = "utf-8"

-- user interface
-----------------
opt.background = "dark"
opt.termguicolors = true -- 24-bit rgb color in the tui
opt.cmdheight = 1 -- number of screen lines to use for the command-line
opt.mouse = "a" -- mouse support; "a" -> all modes
opt.pumheight = 10 -- maximum number of items to show in the popup menu
opt.showmode = false -- mode information at the bottom
opt.showtabline = 0 -- 0 -> never
opt.laststatus = 3 -- 3 -> global statusline
opt.signcolumn = "yes"
opt.shortmess = "ltToOCFsS" -- This option helps to avoid all the |hit-enter|
                            -- prompts caused by file messages for example
                            -- with CTRL-G and to avoid some other messages

-- search & highlight
---------------------
opt.hlsearch = true -- highlight all matches of previous search pattern
opt.incsearch = true -- show match while typing a search command
opt.ignorecase = true -- ignore case when searching
-- opt.smartcase  = true -- enable smart case search

-- fold settings
----------------
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = false
opt.foldcolumn = "0"
opt.foldtext = ""
opt.foldnestmax = 1
opt.foldlevel = 99

-- indentation & tab
--------------------
-- opt.smartindent = true -- smart autoindenting when starting a new line
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
opt.tabstop = 2 -- number of spaces that a <tab> counts for

-- window splitting
-------------------
opt.splitkeep = "cursor" -- "cursor" -> keep the same relative cursor position
                         -- "screen" -> keep the text on the same screen line
opt.splitbelow = true -- force horizontal splits to open below current window
opt.splitright = true -- force vertical splits to open to the right

-- misc
-------
opt.timeoutlen = 500 -- milliseconds to wait for a mapped sequence to complete
opt.updatetime = 750
opt.clipboard = "unnamedplus" -- "unnamedplus" -> use system clipboard for
                              -- copy/paste operations

-- wrap
-------
opt.wrap = true -- line wrapping
opt.linebreak = true -- break lines at convenient points (do not break words)
opt.whichwrap:append "<>[]hl" -- go to previous/next line with h,l,left arrow
                              -- and right arrow when cursor reaches
                              -- end/beginning of line

opt.colorcolumn = "80" -- highlight column 80 (acts as a guide)
opt.cursorline = true
opt.fillchars:append({ eob = " " }) -- remove '~' symbol from empty lines

opt.number = true -- absolute line numbers
opt.relativenumber = true -- relative line numbers
opt.numberwidth = 2 -- width of the number column

-- 44 -> comma
-- 46 -> period
-- 48-57 -> correspond to the digits 0-9
opt.iskeyword = "_,-,+,=,<,>,(,),{,},[,],\",',:,;,\\,/,#,%,&,*,44,46,48-57"
-- opt.iskeyword:append({'-', ';'}) -- define characters that form part of a word
--
-- stylua: ignore start

-- neovide
----------
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
