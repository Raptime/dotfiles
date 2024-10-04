# history file
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# use normal keybinds
bindkey -e

# completion
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit

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

# set window title
function set_win_title(){
    echo -ne "\033]0; $USER@$HOSTNAME \007"
}
starship_precmd_user_func="set_win_title"

#start starship
eval "$(starship init zsh)"
