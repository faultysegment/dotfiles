set nocompatible              " be iMproved, required
set clipboard=unnamedplus
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

"dein Scripts
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/./dein.vim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/bundle/./dein.vim')
  call dein#begin('~/.vim/bundle/./dein.vim')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/bundle/./dein.vim/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('c0r73x/neotags.nvim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('majutsushi/tagbar')
  call dein#add('https://github.com/sheerun/vim-polyglot')
  call dein#add('https://github.com/vim-syntastic/syntastic')
  call dein#add('https://github.com/SirVer/ultisnips')
  call dein#add('fatih/vim-go')
  call dein#add('bling/vim-airline')
  call dein#add('tpope/vim-surround')
  call dein#add('flazz/vim-colorschemes')
  call dein#add('https://github.com/rakr/vim-one')
  call dein#add('Chiel92/vim-autoformat')
  call dein#add('cazador481/fakeclip.neovim')
  call dein#add('roxma/nvim-completion-manager')
  call dein#add('roxma/clang_complete')
  call dein#add('arakashic/chromatica.nvim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

" ---------------------------------- "
" Configure NERDTree
" ---------------------------------- "

" Open NERDTree with Ctrl-n
map <C-n> :NERDTreeToggle<CR>
" Neotags
let g:neotags_enabled=1

" Chromatica
let g:chromatica#enable_at_startup=1
" If chromatica failed update this path
let g:chromatica#libclang_path='/usr/lib/llvm-3.8/lib/libclang.so.1'

" <Plug>(clang_complete_goto_declaration_preview)
au FileType c,cpp  nmap gd <Plug>(clang_complete_goto_declaration)

" Autocomplete
" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" fakeclip
let g:vim_fakeclip_tmux_plus=1 

" ---------------------------------- "
" Configure Ultisnip and YouCompleteMe
" ---------------------------------- "
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

au BufWrite *cpp,*h :Autoformat

"use goimports for formatting
let g:go_fmt_command = "gofmt"

" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

" Goto definition with F3
" Call YCM GoTo or vim-go GoTo depending on file type.
function! GoToDef()
	if &ft == 'go'
		execute 'GoDef'
	else
        "
	endif
endfunction
nnoremap <F3> :call GoToDef()<CR>

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
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {
			\ 'ctagstype' : 'go',
			\ 'kinds'     : [
			\ 'p:package',
			\ 'i:imports:1',
			\ 'c:constants',
			\ 'v:variables',
			\ 't:types',
			\ 'n:interfaces',
			\ 'w:fields',
			\ 'e:embedded',
			\ 'm:methods',
			\ 'r:constructor',
			\ 'f:functions'
			\ ],
			\ 'sro' : '.',
			\ 'kind2scope' : {
			\ 't' : 'ctype',
			\ 'n' : 'ntype'
			\ },
			\ 'scope2kind' : {
			\ 'ctype' : 't',
			\ 'ntype' : 'n'
			\ },
			\ 'ctagsbin'  : 'gotags',
			\ 'ctagsargs' : '-sort -silent'
			\ }
source ~/.config/nvim/init.vim.local
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
	"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
	set termguicolors
endif
colorscheme one
let g:airline_theme='one'
set background=dark

