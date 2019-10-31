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
set linebreak
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
set nofoldenable
set splitbelow
set splitright
set laststatus=2  " Show statusbar even when not split
set backupcopy=yes
set ignorecase
set smartcase
set mouse=a " just to make it easier on colleagues

set wildignore+=*/node_modules/*,*/__pycachce__/*,*.pyc,*.swp,*.bak,*.class

" Bind to save 
nnoremap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>a
vnoremap <C-s> <esc>:w<cr>v
map <Esc><Esc> :w<CR>

" Bind to dølete line (without copying)
nnoremap ø "_dd
vnoremap ø "_d

" Bind to find + ræplace
nnoremap æ :%s ///g<C-left><right>
vnoremap æ :s ///g<C-left><right>

" Bind to tåggle folds
nnoremap å za
vnoremap å za
" Bind to Åpen folds
nnoremap Å :set fdm=syntax<cr>:set fdm=manual<cr>zA
vnoremap Å :set fdm=syntax<cr>:set fdm=manual<cr>zA

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
" What is even an Ex mode go away
nnoremap Q <Nop>

autocmd StdinReadPre * let s:std_in=1

. "$HOME/z.sh"

if executable("brew")
  set rtp+=/usr/local/opt/fzf
else
  set rtp+=~/.fzf
endif
nnoremap <Space>k :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag -lg ""'
nnoremap <Space>f :Ack<space>

let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev Ag Ack

let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o,*.SGO'
let g:javascript_sql_dialect = 'pgsql'

" !!Experimental craziness!!
nnoremap vmc :e ~/.vimrc<CR>
autocmd BufWritePost .vimrc :source %
