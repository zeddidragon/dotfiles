bindkey -v

# Source .bash_profile
source $HOME/.bash_profile

fpath+=($HOME/.zfunctions /usr/local/share/zsh-completions /usr/local/share/zsh/site-functions)
# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt extended_glob

autoload -U promptinit; promptinit
prompt pure

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
