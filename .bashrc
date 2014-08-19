export HISTCONTROL=ignoredups

export LS_OPTIONS='--color=auto -F'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias l='ls -l'
alias la='l -a'
alias ll='l -A'
alias lh='l -h'
alias h='history 25'
alias j='jobs -l'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

ulimit -S -c 0        # Don't want any coredumps
set -o notify
shopt -s checkwinsize

PS1='\[\e[0;34m\][\[\e[0m\]\u@\h \w\[\e[0;34m\]]\[\e[0m\]\$ '
case "$TERM" in
xterm*|rxvt*)
PS1="\[\e]0;\u@\h: \w\a\]$PS1"
;;
*)
;;
esac


