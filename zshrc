[[ -f ~/.bash_profile ]] && . ~/.bash_profile

export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8

fpath+=($HOME/.zfunctions)

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt extended_glob
autoload -Uz compinit
compinit

export VISUAL=vim
export EDITOR=$VISUAL
export PAGER=less

alias clip='xclip -i -selection clipboard'

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

if [[ "$SSH_TTY" = "" ]]; then
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

eval "$(starship init zsh)"
fpath+=${ZDOTDIR:-~}/.zsh_functions
