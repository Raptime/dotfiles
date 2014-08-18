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

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

ulimit -S -c 0        # Don't want any coredumps
set -o notify
shopt -s checkwinsize

#PS1='[\u@\h:\w]\$'
PS1='\[\e[0;34m\][\[\e[0m\]\u@\h \w\[\e[0;34m\]]\[\e[0m\]\$ '
PS1="\[\e]0;\u@\h: \W\a\]$PS1"







