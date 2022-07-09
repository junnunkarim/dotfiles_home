call plug#begin('~/.vim')
	"Tools
	Plug 'itchyny/lightline.vim'
	Plug 'junegunn/goyo.vim'
	Plug 'preservim/tagbar'
	Plug 'farmergreg/vim-lastplace'
	Plug 'jiangmiao/auto-pairs'
	"Plug 'cohama/lexima.vim'
	"Plug 'ryanoasis/vim-devicons'
	"Plug 'preservim/vim-markdown'
	"Plug 'ap/vim-css-color'
	Plug 'elkowar/yuck.vim'

	" autocomplete
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	"ColorSchemes
	Plug 'ntk148v/vim-horizon'
	Plug 'pineapplegiant/spaceduck', { 'branch': 'main'  }
	Plug 'morhetz/gruvbox'
	Plug 'ghifarit53/tokyonight-vim'
	Plug 'ayu-theme/ayu-vim'
	Plug 'arcticicestudio/nord-vim'
	Plug 'cocopon/iceberg.vim'
	Plug 'ajmwagar/vim-deus'
	Plug 'dracula/vim', { 'as': 'dracula'  }
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()

"ColorScheme Config
	let ayucolor="dark" "light, mirage, dark
	let g:tokyonight_enable_italic = 1
	let g:tokyonight_style = 'storm' " available: night, storm

"Vim native options
	"set foldmethod=syntax

	set tabstop=2
	set shiftwidth=0
	set backspace=2

	set cursorline
	set linebreak
	set wrap
	set noshowmode
	set number
	set laststatus=2
	set encoding=UTF-8
	set ttimeoutlen=3

	set mouse=a 

	if (has("termguicolors"))
		set termguicolors
	endif

	set background=dark
	colorscheme gruvbox

"Fix colors in Alacritty
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"Move cursor in insert mode
	"inoremap <C-k> <C-o>gk
	"inoremap <C-h> <Left>
	"inoremap <C-l> <Right>
	"inoremap <C-j> <C-o>gj

"Tools Config
	"Vim native file manager - Netrw
	let g:netrw_banner = 0
	let g:netrw_liststyle = 3
	let g:netrw_browse_split = 3
	let g:netrw_winsize = 25

	"tagbar
	nmap <F8> :TagbarToggle<CR>

	"Lightline
	let g:lightline = {
      \ 		                                                  'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'  ],
      \             [ 'readonly', 'filename'  ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \ },
\ }
	function! LightlineFilename()
	  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
		let modified = &modified ? ' +' : ''
		return filename . modified
	endfunction
	function! LightlineFileformat()
	  return winwidth(0) > 70 ? &fileformat : ''
  endfunction
  function! LightlineFiletype()
	    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
	endfunction

	" vim-markdown
	let g:vim_markdown_folding_disabled = 1

	"<new plugin settings>
