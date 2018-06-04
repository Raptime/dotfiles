# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTCONTROL=ignoreboth #ignoredups + ignorespace
export HISTFILESIZE=10000
export HISSIZE=10000
export HISTTIMEFORMAT='%F %T '

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto -F'
alias l='ls -l'
alias la='l -a'
alias ll='l -A'
alias lh='l -h'
alias h='history 25'
alias j='jobs -l'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

ulimit -S -c 0        # Don't want any coredumps
set -o notify
shopt -s cmdhist
shopt -s checkwinsize
shopt -s histappend


#prompt color
__context_color_count() {
  printf "%d" $(infocmp -1 | sed -n -e "s/^\t*colors#\([0-9]x\?[0-9]*\),.*/\1/p")
}

__context_color_hash() {
  eval "whoami; hostname" | sum | cut -d' ' -f1
}

__context_color_number() {
  expr 1 + $(__context_color_hash) % $(expr $(__context_color_count) - 1)
#  expr 1 + $(__context_color_hash) % 8
}

__context_color_sequence() {
  local sequence="$(tput setaf $(__context_color_number))"
#  sequence="\[${sequence}\]"
  echo "$sequence"
}
PCOLOR="$(__context_color_sequence)"
PRESET="$(tput sgr0)"

#PS1='\[\e[0;34m\][\[\e[0m\]\u@\h \W\[\e[0;34m\]]\[\e[0m\]\$ '
#PS1="$PCOLOR[$PRESET\u$PCOLOR@$PRESET\h \W$PCOLOR]$PRESET\$ "
PS1="$PCOLOR\u@\h$PRESET:\W\\$ "
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;\u@\h:\w\a\]$PS1"
        ;;
    *)
        ;;
esac

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f $HOME/.bashrc.local ]; then
    . $HOME/.bashrc.local
fi
