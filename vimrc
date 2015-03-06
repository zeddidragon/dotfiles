execute pathogen#infect()

" Enable defaults that really should've been enabled in the first place
syntax on
filetype plugin indent on
let g:gruvbox_italic=0
colorscheme gruvbox
" Let me keep my transparent background
set t_Co=256
set background=dark
hi Normal ctermbg=none
set ruler
set backspace=2
set number
set incsearch
set hlsearch
set hidden
set nowrap
set autoindent
set colorcolumn=80
set tabstop=8
set shiftwidth=2
set softtabstop=2
set expandtab
set showmatch
set history=1000
set undolevels=1000
set title
set visualbell
set noerrorbells
set nobackup
set noswapfile

set wildignore+=*/public/*,*/node_modules/*,*/__pycachce__/*,*.pyc,*.swp,*.bak,*.class

" Saving to Ctrl+S like sane person
nnoremap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>a
" Ctrl+X to find+replace
nnoremap æ :%s ///g<C-left><right>
inoremap æ <esc>:%s ///g<C-left><right>
vnoremap æ :s ///g<C-left><righ>

nnoremap ø :NERDTreeFind<cr>
" Tab to autocomplete paths
imap <C-space> <C-x><C-f>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Clear search command
command! C let @/=""

" Make yank copy to clipboard
set clipboard=unnamedplus
nnoremap y "+y
vnoremap y "+y

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
 
" Start NerdTree unless a file was specificed
let g:NERDTreeWinSize=20
let g:NERDTreeChDirMode=2
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

. "$HOME/z.sh"
