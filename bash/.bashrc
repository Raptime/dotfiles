# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export HISTCONTROL=ignoreboth #ignoredups + ignorespace
export HISTFILESIZE=10000
export HISSIZE=10000
export HISTTIMEFORMAT='%F %T '

export EDITOR='vi'
export VISUAL='vi'

#export MANPAGER="less -R --use-color -Dd+r -Du+b"

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls -v --color=auto --classify'
alias l='ls -l'
alias la='l --all'
alias ll='l --almost-all'
alias lh='l --human-readable'
alias h='history 25'
alias j='jobs -l'
alias ip='ip -color'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

ulimit -S -c 0        # Don't want any coredumps
set -o notify
shopt -s cmdhist
shopt -s checkwinsize
shopt -s histappend

test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

if [ -f $HOME/.bashrc.local ]; then
    . $HOME/.bashrc.local
fi

function set_win_title(){
    echo -ne "\033]0; $USER@$HOSTNAME \007"
}
starship_precmd_user_func="set_win_title"

if command -v starship &> /dev/null; then
  eval "$(starship completions bash)"
  eval "$(starship init bash)"
fi
