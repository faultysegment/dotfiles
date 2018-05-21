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

call plug#begin('~/.local/share/nvim/plugged')
Plug 'majutsushi/tagbar'          " Class/module browser
Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'bling/vim-airline'       " Lean & mean status/tabline for vim
Plug 'tpope/vim-surround' "Parentheses, brackets, quotes, XML tags, and more
Plug 'flazz/vim-colorschemes'
Plug 'https://github.com/rakr/vim-one'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/vimproc.vim', {'dir': '~/.local/share/nvim/plugged/vimproc.vim', 'do': 'make' }
" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" " On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'sakhnik/nvim-gdb'
Plug 'sbdchd/neoformat'

call plug#end()
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['cquery', '--log-file=/tmp/cq.log', '--init={"enableComments": 2, "cacheDirectory": "./.cquerydir"}'],
    \ 'c': ['cquery', '--log-file=/tmp/cq.log', '--init={"enableComments": 2, "cacheDirectory": "./.cquerydir"}'],
    \ 'python': ['pyls', '-v'],
    \ } 

let g:LanguageClient_settingsPath = '/home/i_skrypitsa/.config/nvim/settings.json'
let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings 



set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()
let g:deoplete#enable_at_startup = 1
nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

map <C-I> :pyf ~/bin/clang-format.py<cr>
imap <C-I> <c-o>:pyf ~/bin/clang-format.py<cr>

set tags+=./tags
set colorcolumn=80
filetype on
filetype plugin on
filetype plugin indent on
" virtual tabstops using spaces
set shiftwidth=4
set softtabstop=4
set expandtab
" allow toggling between local and default mode
function TabToggle()
	if &expandtab
		set shiftwidth=4
		set softtabstop=0
		set noexpandtab
	else
		set shiftwidth=4
		set softtabstop=4
		set expandtab
	endif
endfunction
set pastetoggle=<F10>
map <F9> mz:execute TabToggle()<CR>'z
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
" Find file in current directory and edit it.
function! Find(name)
	let l:list=system("find . -name '".a:name."' | perl -ne 'print \"$.\\t$_\"' ")
	let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
	if l:num < 1
		echo "'".a:name."' not found"
		return
	endif
	if l:num != 1
		echo l:list
		let l:input=input("Which ? (CR=nothing)\n")
		if strlen(l:input)==0
			return
		endif
		if strlen(substitute(l:input, "[0-9]", "", "g"))>0
			echo "Not a number"
			return
		endif
		if l:input<1 || l:input>l:num
			echo "Out of range"
			return
		endif
		let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
	else
		let l:line=l:list
	endif
	let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
	execute ":e ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")
command! -nargs=1 -complete=file Startdebug :GdbStart gdb -q -f <args>

function! DoPrettyXML()
	" save the filetype so we can restore it later
	let l:origft = &ft
	set ft=
	" delete the xml header if it exists. This will
	" permit us to surround the document with fake tags
	" without creating invalid xml.
	1s/<?xml .*?>//e
	" insert fake tags around the entire document.
	" This will permit us to pretty-format excerpts of
	" XML that may contain multiple top-level elements.
	0put ='<PrettyXML>'
	$put ='</PrettyXML>'
	silent %!xmllint --format -
	" xmllint will insert an <?xml?> header. it's easy enough to delete
	" if you don't want it.
	" delete the fake tags
	2d
	$d
	" restore the 'normal' indentation, which is one extra level
	" too deep due to the extra tags we wrapped around the document.
	silent %<
	" back to home
	1
	" restore the filetype
	exe "set ft=" . l:origft
endfunction

command! PrettyXML call DoPrettyXML()
if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif

" Open NERDTree with Ctrl-n 
map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
set t_Co=256
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
nmap <F8> :TagbarToggle<CR>
colorscheme one
set background=dark
let g:airline_theme='one'
set guicursor=
