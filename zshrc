bindkey -v

# Source .bash_profile
source $HOME/.bash_profile
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in $HOME/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME='robbyrussell'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in $HOME/.oh-my-zsh/plugins/*)
# Custom plugins may be added to $HOME/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
source ~/.tmuxinator.zsh

# User configuration

export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="$HOME/.ssh/dsa_id"

alias bex='bundle exec '
alias clip='xclip -i -selection clipboard'
alias tm='tmux -2'

export NVM_DIR="$HOME/.nvm"
if [ $IS_WSL ]; then
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use  # This loads nvm faster
  export PATH="$PATH:$NVM_DIR/versions/node/v9.2.1/bin/"
else
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  eval "$(rbenv init -)"
fi

alias xclip="xclip -selection c"

source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

# Allow saving with Ctrl-S in terminal vim
vim() STTY=-ixon command vim "$@"

# z.sh
. "$HOME/z.sh"

alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'

alias glhf="git pull --rebase && git push"

export HISTCONTROL=ignorespace

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Arrow key completion
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
