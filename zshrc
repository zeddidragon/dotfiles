# Source .bash_profile
source $HOME/.bash_profile

fpath+=($HOME/.zfunctions)
# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt extended_glob

export EDITOR='vim'

alias clip='xclip -i -selection clipboard'

nvm_dir="$HOME/.nvm"
if [ -d "$nvm_dir" ]; then
export NVM_DIR="$nvm_dir"
  if [ $IS_WSL ]; then
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use  # This loads nvm faster
    export PATH="$PATH:$NVM_DIR/versions/node/v9.2.1/bin/"
  else
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  fi
fi

if hash tmuxinator 2>/dev/null; then
  source ~/.tmuxinator.zsh
fi

autoload -U promptinit; promptinit
prompt pure
PROMPT='%F{cyan}%* '$PROMPT

source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

# Allow saving with Ctrl-S in terminal vim
vim() STTY=-ixon command vim "$@"

# z.sh
. "$HOME/z.sh"

alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'

alias gl="git pull"
alias gp="git push"
alias gc="git checkout"
alias gm="git merge"
alias gcp="git cherry-pick"
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

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if hash gpgconf 2>/dev/null; then
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  export GPG_TTY=$(tty)
  alias recard="killall -9 gpg-agent ; gpg --card-status"
fi

bindkey -v
export KEYTIMEOUT=1
bindkey "^R" history-incremental-search-backward
