execute pathogen#infect()

" Enable defaults that really should've been enabled in the first place
syntax on
filetype plugin indent on
colorscheme gruvbox
set background=dark
set ruler
set backspace=2
set number
set incsearch
set hlsearch

" Map saving to Ctrl+S like sane person
nnoremap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>a
" Map Ctrl+X to find+replace
map <C-x> :%s ///g<C-left><right>

" Clear search command
command! C let @/=""

" Make yank copy to clipboard
set clipboard=unnamedplus
nnoremap y "+y
vnoremap y "+y

" Ruby things
set colorcolumn=80

set smartindent
set tabstop=8
set shiftwidth=2
set softtabstop=2
set expandtab

" CtrlP
set wildignore+=*/public/*,*/node_modules/*,*/__pycachce__/*,*.pyc

" NERDTree
" Check if NERDTree is open or active
function! rc:isNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction
 
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! rc:syncTree()
  if &modifiable && rc:isNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction
 
" Highlight currently open buffer in NERDTree
autocmd BufEnter * call rc:syncTree()

" Start NerdTree unless a file was specificed
let g:NERDTreeWinSize=20
let g:NERDTreeChDirMode=2
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

. "$HOME/z.sh"
