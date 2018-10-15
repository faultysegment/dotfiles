set nocompatible              " be iMproved, required

" Plugins section
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'majutsushi/tagbar'      " Class/module browser
  Plug 'bling/vim-airline'     " Lean & mean status/tabline for vim
  Plug 'tpope/vim-surround' "Parentheses, brackets, quotes, XML tags, and more
  Plug 'tpope/vim-fugitive' " Git
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  " Autocompletion
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  Plug 'Shougo/deoplete.nvim'
  " Go support
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'zchee/deoplete-go', { 'do': 'make'}

  " C/C++ debugger
  Plug 'dbgx/lldb.nvim'
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

" LanguageClient Settings
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['cquery', '--log-file=/tmp/cq.log', '--init={"enableComments": 2, "cacheDirectory": "./.cquerydir"}'],
  \ 'c': ['cquery', '--log-file=/tmp/cq.log', '--init={"enableComments": 2, "cacheDirectory": "./.cquerydir"}'],
  \ 'python': ['pyls', '-v'],
  \ } 

set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

let g:deoplete#enable_at_startup = 1

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
map <F9> mz:execute TabToggle()<CR>'z
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Open NERDTree with Ctrl-n 
map <C-n> :NERDTreeToggle<CR>

nmap <F8> :TagbarToggle<CR>
