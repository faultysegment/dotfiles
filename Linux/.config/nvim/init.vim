set nocompatible              " be iMproved, required

" Plugins section
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'bling/vim-airline'     " Lean & mean status/tabline for vim
  Plug 'tpope/vim-surround' "Parentheses, brackets, quotes, XML tags, and more
  Plug 'tpope/vim-fugitive' " Git
  Plug 'Shougo/denite.nvim'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  " Autocompletion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-go', { 'do': 'make' }
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#sources#go = ['vim-go']

  " Go
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  " Theme
  Plug 'joshdick/onedark.vim'
call plug#end()

"Generic settings
set clipboard=
set mouse=a
set nu
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noswapfile
set list
set listchars=trail:.,tab:>>
set hls
filetype on
filetype plugin indent on
syntax enable
" Required for operations modifying multiple buffers like rename.
set hidden
set tags+=./tags
set colorcolumn=120
filetype plugin indent on
" virtual tabstops using spaces
set t_Co=256
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
set pastetoggle=<F10>
set guicursor=

colorscheme onedark
let g:airline_theme='onedark'

" allow toggling between local and default mode
function TabToggle()
  if &expandtab
    set shiftwidth=2
    set softtabstop=0
    set noexpandtab
  else
    set shiftwidth=2
    set softtabstop=2
    set expandtab
  endif
endfunction

" Key mapping
map <F8> mz:execute TabToggle()<CR>'z
" Open NERDTree with Ctrl-n 
map <C-n> :NERDTreeToggle<CR>
