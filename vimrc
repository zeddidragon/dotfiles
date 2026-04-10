call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'morhetz/gruvbox'
Plug 'kchmck/vim-coffee-script'
Plug 'airblade/vim-gitgutter'
Plug 'wavded/vim-stylus'
Plug 'tikhomirov/vim-glsl'
Plug 'plasticboy/vim-markdown'
Plug 'jonsmithers/vim-html-template-literals'
Plug 'pangloss/vim-javascript'
Plug 'ElmCast/elm-vim'
Plug 'cespare/vim-toml'
Plug 'elixir-lang/vim-elixir'
Plug 'rust-lang/rust.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'vim-scripts/dbext.vim'
Plug 'fidian/hexmode'
Plug 'digitaltoad/vim-pug'
Plug 'iamcco/markdown-preview.nvim'
Plug 'vim-scripts/bbcode'
Plug 'ollykel/v-vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/goyo.vim'
Plug 'goldfeld/vim-seek'
Plug 'junegunn/limelight.vim'
Plug 'sgur/vim-editorconfig'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'junegunn/fzf'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'ziglang/zig.vim'
Plug 'radgeRayden/vim-scopes'
Plug 'leafgarland/typescript-vim'
Plug 'othree/html5.vim'
Plug 'evanleck/vim-svelte'
Plug 'habamax/vim-godot '
Plug 'chikamichi/mediawiki.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'Lord-Leonard/vim-aspnet'
Plug 'OrangeT/vim-csharp'
Plug 'elzr/vim-json'

call plug#end()

" Enable defaults that really should've been enabled in the first place
syntax on
filetype plugin on
filetype plugin indent on
filetype indent plugin on
colorscheme gruvbox
" Let me keep my transparent background
set t_Co=256
set background=dark
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
hi Normal ctermbg=NONE guibg=NONE
set ruler
set backspace=2
set number
set relativenumber

set incsearch
set hlsearch
set hidden
set nowrap
set linebreak
set autoindent
set colorcolumn=72
set tabstop=2
set list
set listchars=tab:>-
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
set mouse=a
set nocompatible  " Disable backwards compatibility with Vi
set formatoptions-=t  " Disable insertion of newlines

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


" asynccomplete
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Ctrl+space to autocomplete paths
imap <C-space> <C-x><C-f>
set path +=**

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
tmap <C-h> <C-w>h
tmap <C-j> <C-w>j
tmap <C-k> <C-w>k
tmap <C-l> <C-w>l

" Quick splitting
map <space>v :vs<CR>
map <space>h :split<CR>

" Clear search command
command! C let @/=""
nmap <space>c :C<CR>:e!<CR>

set clipboard^=unnamed,unnamedplus

autocmd StdinReadPre * let s:std_in=1

. "$HOME/z.sh"

if executable("brew")
  set rtp+=/usr/local/opt/fzf
else
  set rtp+=~/.fzf
endif
nnoremap <Space>k :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag -Ulg ""'
nnoremap <Space>f :Ack<space>

let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev Ag Ack

let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o,*.SGO'
let g:ale_echo_msg_format = '%linter% says %s'
let g:ale_linters = {
\   'cs': ['OmniSharp']
\}

" !!Experimental craziness!!
nmap <space>r :!tmux send-keys -t .+ Up Enter<CR><CR>
nmap <space>y :let @+=@"<CR>:let @*=@"<CR>
nmap <space>p :let @"=@+<CR>p
" K is split line, opposite J which is join line
nnoremap K i<CR><Esc>

" override tab settings on a per-directory basis
function! SetStandardTabs()
  set noexpandtab
  set tabstop=4
  set softtabstop=0
  set shiftwidth=4
endfunction

set nofixendofline

let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_finusages = 'fzf'

" automatically mark Css, Html, and Js files for quickly working with a component
augroup VIMRC
  autocmd!
  autocmd BufLeave *.css       normal! mC
  autocmd BufLeave *.html      normal! mH
  autocmd BufLeave *.js,*.ts   normal! mJ
augroup END
