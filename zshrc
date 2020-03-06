# Source .bash_profile
source $HOME/.bash_profile
fpath+=($HOME/.zfunctions)
fpath+=('/home/tony/.nvm/versions/node/v13.7.0/lib/node_modules/pure-prompt/functions')
PROMPT='%F{cyan}%* '$PROMPT

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt extended_glob
autoload -Uz compinit
compinit
# Completion for kitty
# kitty + complete setup zsh | source /dev/stdin

export VISUAL=vim
export EDITOR=$VISUAL
export PAGER=less

alias clip='xclip -i -selection clipboard'

autoload -U promptinit; promptinit
prompt pure

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

source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

# Allow saving with Ctrl-S in terminal vim
vim() STTY=-ixon command vim "$@"

# z.sh
. "$HOME/z.sh"

alias fuck='eval $(thefuck $(fc -ln | tail -n 1)); fc -R'

alias gl="git pull"
alias gp="git push"
alias gc="git checkout"
alias gm="git merge"
alias gcp="git cherry-pick"
alias glhf="git pull --rebase && git push"
alias prim="vim -Nu ~/.primrc"
alias icat="kitty +kitten icat"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Arrow key completion
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/bin:$PATH"

if hash gpgconf 2>/dev/null; then
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  export GPG_TTY=$(tty)
  alias recard="killall -9 gpg-agent ; gpg --card-status"
fi

SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    echo succeeded
    chmod 600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

bindkey -v
export KEYTIMEOUT=1
export SAVEHIST=16384
export HISTSIZE=65536
export HISTFILE="$HOME/.zsh_history"
export HISTCONTROL=ignorespace
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
bindkey "^R" history-incremental-pattern-search-backward
