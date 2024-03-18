# set XDG stuff
export XDG_DATA_HOME=$HOME'/.local/share'
export XDG_CONFIG_HOME=$HOME'/.config'
export XDG_STATE_HOME=$HOME'/.local/state'
export XDG_CACHE_HOME=$HOME'/.cache'

# home folder cleanup
export GTK2_RC_FILES=$XDG_CONFIG_HOME'/gtk-2.0/gtkrc'
export LESSHISTFILE=$XDG_STATE_HOME'/less/history'
export HISTFILE=$XDG_STATE_HOME'/zsh/history'
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"


# make sure we use vi to edit stuff
export EDITOR='vi'
export VISUAL=${EDITOR}

# man color
export MANPAGER="less -R --use-color -Dd+g -Du+b"

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
