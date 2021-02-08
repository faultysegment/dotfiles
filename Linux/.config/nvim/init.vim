set nocompatible              " be iMproved, required

" Plugins section
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'tpope/vim-surround' "Parentheses, brackets, quotes, XML tags, and more
 
  Plug 'tpope/vim-fugitive' " Git
  
  Plug 'Shougo/denite.nvim'

  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'liuchengxu/vista.vim'

  Plug 'dense-analysis/ale'
  Plug 'itchyny/lightline.vim'
  " Auto completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Theme
  Plug 'rakr/vim-one'
  Plug 'joshdick/onedark.vim'

  Plug 'ekalinin/Dockerfile.vim'
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

set spell
" spell languages
set spelllang=en,cjk

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

colorscheme one
set background=dark
let g:airline_theme='one'

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
map <F9> :Vista!!<CR>
" Open NERDTree with Ctrl-n 
map <C-n> :NERDTreeToggle<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <Leader>j <Plug>(coc-diagnostic-next-error)
nmap <silent> <Leader>k <Plug>(coc-diagnostic-prev-error)

nmap <F7> :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Vista settings
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1
let g:vista_executive_for = {
  \ 'go': 'ctags',
  \ }
function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
endfunction

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

" Lightline
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'filename', 'readonly', 'modified', 'method' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'cocstatus' ],
      \              [ 'fileformat', 'fileencoding' ] ]
      \ },
      \ 'component_function': {
      \   'method': 'NearestMethodOrFunction',
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'StatusDiagnostic'
      \ },
      \ }

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc 
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" vim-go
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
