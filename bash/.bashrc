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

PROMPT_COMMAND=__prompt_command

__prompt_command() {
  local PERR="$?"
  PS1=""

  local PCOLOR_SSH="\[$(tput setaf 6)\]" #Cyan
  local PCOLOR_ERR="\[$(tput setaf 5)\]" #Purple
  local PRESET="\[$(tput sgr0)\]"

  #prompt host
  if [ -n "${SSH_CLIENT-}${SSH2_CLIENT-}${SSH_TTY-}" ]; then
    local PHOST="@$PCOLOR_SSH\h$PRESET"
  else
    local PHOST=""
  fi

  #prompt error
  if [ $PERR != 0 ]; then
    PS1+="$PCOLOR_ERR[$PERR]$PRESET"
  fi

  #prompt perm
  if [ -w "${PWD}" ]; then
    local PPERM=":"
  else
    local PPERM="$PCOLOR:$PRESET"
  fi

#  PS1+="\u$PHOST$PPERM\W\\$ "
  PS1+="\u$PHOST:\W\\$ "

  case "$TERM" in
    xterm*|rxvt*)
      PS1="\[\e]0;\u@\h\a\]$PS1"
      ;;
    *)
      ;;
  esac
}

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f $HOME/.bashrc.local ]; then
    . $HOME/.bashrc.local
fi
