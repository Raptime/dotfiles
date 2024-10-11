# options
setopt always_to_end
setopt automenu
setopt complete_in_word
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_space
setopt interactivecomments

# history file
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# history search
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# completion
zstyle ':completion:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compcache
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion::complete:*' use-cache yes
autoload -Uz compinit
compinit

# keybinds
# use emacs keybinds
bindkey -e
# custom keybinds
bindkey '\e[A' up-line-or-beginning-search # Up
bindkey '\eOA' up-line-or-beginning-search # Up
bindkey '\e[B' down-line-or-beginning-search # Down
bindkey '\eOB' down-line-or-beginning-search # Down

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
