set nocompatible              " be iMproved, required
set clipboard=
set mouse=a
set nu
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set noswapfile
set list
set listchars=trail:.,tab:>>
set hls
syntax on
filetype indent plugin on

" Required:
filetype plugin indent on
syntax enable

" Required for operations modifying multiple buffers like rename.
set hidden

set colorcolumn=80
filetype on
filetype plugin on
filetype plugin indent on
" virtual tabstops using spaces
set shiftwidth=4
set softtabstop=4
set expandtab
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

set background=dark
