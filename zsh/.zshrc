# path
export PATH=$HOME/.local/bin:$PATH

# options
setopt interactivecomments

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# history search
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# completion
setopt always_to_end
setopt automenu
setopt complete_in_word
zstyle ':completion:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compcache
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion::complete:*' use-cache yes
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# keybinds
# use emacs keybinds
bindkey -e
# custom keybinds
bindkey	'\e[A'	up-line-or-beginning-search # Up
bindkey	'\eOA'	up-line-or-beginning-search # Up
bindkey	'\e[B'	down-line-or-beginning-search # Down
bindkey	'\eOB'	down-line-or-beginning-search # Down
bindkey	"^[[H"	beginning-of-line
bindkey	"^[[F"	end-of-line
bindkey	"^[[3~"	delete-char

# magic
autoload -Uz bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N bracketed-paste bracketed-paste-magic
zle -N self-insert url-quote-magic

# make sure we use vi to edit
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
    echo -ne "\033]0; $USER@$HOST \007"
}
precmd_functions+=(set_win_title)

#start starship
eval "$(starship init zsh)"
