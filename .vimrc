execute pathogen#infect()
syntax on
filetype plugin indent on
colorscheme gruvbox
set ruler
set backspace=2
set number

" Start NerdTree unless a file was specificed
let g:NERDTreeWinSize=20
let g:NERDTreeChDirMode=2
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Make yank copy to clipboard
set clipboard=unnamedplus
nnoremap y "+y
vnoremap y "+y

" Ruby things
set colorcolumn=80

set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
au BufRead,BufNewFile *.jbuilder setfiletype ruby
au BufRead,BufNewFile Capfile setfiletype ruby

" HTML things
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" Python things
function SetPythonOptions()
	setlocal tabstop=4
	setlocal shiftwidth=4
	setlocal colorcolumn=78
endfunction

autocmd FileType python SetPythonOptions()

" CtrlP
set wildignore+=*\\public\\*,*/public/*
