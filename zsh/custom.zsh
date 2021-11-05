# make sure we use vi to edit stuff
export EDITOR='vi'
export VISUAL=${EDITOR}

# import dircolors
test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

# aliases
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
