execute pathogen#infect()

" Enable defaults that really should've been enabled in the first place
syntax on
filetype plugin indent on
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
set wrap
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
set nofoldenable  " fuck folding
set splitbelow
set splitright
set laststatus=2  " Show statusbar even when not split

set wildignore+=*/node_modules/*,*/__pycachce__/*,*.pyc,*.swp,*.bak,*.class

" Bind to save 
nnoremap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>a

" Bind to find + ræplace
nnoremap æ :%s ///g<C-left><right>
vnoremap æ :s ///g<C-left><right>

" Tab to autocomplete paths
imap <C-space> <C-x><C-f>
set path +=**

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Clear search command
command! C let @/=""

" Make yank copy to clipboard
set clipboard^=unnamed,unnamedplus
nnoremap y "+y
vnoremap y "+y
" What is even an Ex mode go away
nnoremap Q <Nop>

autocmd StdinReadPre * let s:std_in=1

. "$HOME/z.sh"

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_javascript_checkers = ['eslint']

set rtp+=~/.fzf
nnoremap <C-p> :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
