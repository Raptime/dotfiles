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


_LP_RUNTIME_LAST_SECONDS=$SECONDS

_lp_runtime()
{
    if (( _LP_RUNTIME_SECONDS >= 2 ))
    then
        # display runtime seconds as days, hours, minutes, and seconds
        (( _LP_RUNTIME_SECONDS >= 86400 )) && echo -n $((_LP_RUNTIME_SECONDS / 86400))d
        (( _LP_RUNTIME_SECONDS >= 3600 )) && echo -n $((_LP_RUNTIME_SECONDS % 86400 / 3600))h
        (( _LP_RUNTIME_SECONDS >= 60 )) && echo -n $((_LP_RUNTIME_SECONDS % 3600 / 60))m
        echo -n $((_LP_RUNTIME_SECONDS % 60))"s "
    fi
    :
}

_lp_runtime_before()
{
    # If the previous command was just the refresh of the prompt,
    # reset the counter
    if (( _LP_RUNTIME_SKIP )); then
        _LP_RUNTIME_SECONDS=-1 _LP_RUNTIME_LAST_SECONDS=$SECONDS
    else
        # Compute number of seconds since program was started
        (( _LP_RUNTIME_SECONDS=SECONDS-_LP_RUNTIME_LAST_SECONDS ))
    fi

    # If the command to run is the prompt, we'll have to ignore it
    [[ "$BASH_COMMAND" != "$PROMPT_COMMAND" ]]
    _LP_RUNTIME_SKIP=$?
}

_LP_RUNTIME_SKIP=0
# _lp_runtime_before gets called just before bash executes a command,
# including $PROMPT_COMMAND
trap _lp_runtime_before DEBUG





__prompt_command() {
  local PERR="$?"
  PS1=""

  local PCOLOR_PAT="\[$(tput bold)\]" #Bold
  local PCOLOR_ROO="\[$(tput bold tput setaf 3)\]" #Bold Yellow
  local PCOLOR_RUN="\[$(tput setaf 3)\]" #Yellow
  local PCOLOR_SSH="\[$(tput setaf 6)\]" #Cyan
  local PCOLOR_ERR="\[$(tput setaf 5)\]" #Purple
  local PRESET="\[$(tput sgr0)\]"

  #prompt host
  if [ -n "${SSH_CLIENT-}${SSH2_CLIENT-}${SSH_TTY-}" ]; then
    local PHOST="@$PCOLOR_SSH\h$PRESET"
  elif [[ "$TERM" == screen* ]]; then
    local PMULT="tmux"
    local PHOST="@$PCOLOR_SSH$PMULT$PRESET"
  else
    local PHOST=""
  fi

  #prompt path
  if (( EUID !=0 )); then
    local PPATH="$PCOLOR_PAT\W$PRESET"
  else
    local PPATH="$PCOLOR_ROO\W$PRESET"
  fi

  #prompt runtime
  local PRUNTIME="$PCOLOR_RUN$(_lp_runtime)$PRESET"

  #build prompt
  PS1+="$PRUNTIME"
  #prompt error
  if [ $PERR != 0 ]; then
    PS1+="$PCOLOR_ERR[$PERR]$PRESET"
  fi
  PS1+="\u$PHOST:$PPATH\\$ "

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
