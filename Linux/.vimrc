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
set background=dark
