# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTCONTROL=ignoreboth #ignoredups + ignorespace
export HISTFILESIZE=10000
export HISSIZE=10000
export HISTTIMEFORMAT='%F %T '

export EDITOR='vi'
export VISUAL='vi'

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

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

ulimit -S -c 0        # Don't want any coredumps
set -o notify
shopt -s cmdhist
shopt -s checkwinsize
shopt -s histappend

PROMPT_COMMAND=__prompt_command


_PRUNTIME_LAST_SECONDS=$SECONDS

_pruntime()
{
    if (( _PRUNTIME_SECONDS >= 2 ))
    then
        # display runtime seconds as days, hours, minutes, and seconds
        (( _PRUNTIME_SECONDS >= 86400 )) && echo -n $((_PRUNTIME_SECONDS / 86400))d
        (( _PRUNTIME_SECONDS >= 3600 )) && echo -n $((_PRUNTIME_SECONDS % 86400 / 3600))h
        (( _PRUNTIME_SECONDS >= 60 )) && echo -n $((_PRUNTIME_SECONDS % 3600 / 60))m
        echo -n $((_PRUNTIME_SECONDS % 60))"s "
    fi
    :
}

_pruntime_before()
{
    # If the previous command was just the refresh of the prompt,
    # reset the counter
    if (( _PRUNTIME_SKIP )); then
        _PRUNTIME_SECONDS=-1 _PRUNTIME_LAST_SECONDS=$SECONDS
    else
        # Compute number of seconds since program was started
        (( _PRUNTIME_SECONDS=SECONDS-_PRUNTIME_LAST_SECONDS ))
    fi

    # If the command to run is the prompt, we'll have to ignore it
    [[ "$BASH_COMMAND" != "$PROMPT_COMMAND" ]]
    _PRUNTIME_SKIP=$?
}

_PRUNTIME_SKIP=0
# _pruntime_before gets called just before bash executes a command,
# including $PROMPT_COMMAND
trap _pruntime_before DEBUG

# GIT #
# Get the branch name of the current directory
_pgit_branch()
{
    \git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

    local branch
    if branch="$(\git symbolic-ref --short -q HEAD)"; then
        echo $branch
    else
        # In detached head state, use commit instead
        # No escape needed
        \git rev-parse --short -q HEAD
    fi
}

_pgit_branch_color()
{

  local PCOLOR_UP="\[$(tput setaf 2)\]" #Green
  local PCOLOR_COMMITS="\[$(tput setaf 3)\]" #Yellow
  local PCOLOR_COMMITS_BEHIND="\[$(tput bold)$(tput setaf 1)\]" #Red
  local PCOLOR_CHANGES="\[$(tput setaf 1)\]" #Red
  local PCOLOR_DIFF="\[$(tput setaf 5)\]" #Purple
  local PRESET="\[$(tput sgr0)\]"

    local branch
    branch="$(_pgit_branch)"
    if [[ -n "$branch" ]]; then

        local remote
        remote="$(\git config --get branch.${branch}.remote 2>/dev/null)"

        local has_commit=""
        local commit_ahead
        local commit_behind
        if [[ -n "$remote" ]]; then
            local remote_branch
            remote_branch="$(\git config --get branch.${branch}.merge)"
            if [[ -n "$remote_branch" ]]; then
                remote_branch=${remote_branch/refs\/heads/refs\/remotes\/$remote}
                commit_ahead="$(\git rev-list --count $remote_branch..HEAD 2>/dev/null)"
                commit_behind="$(\git rev-list --count HEAD..$remote_branch 2>/dev/null)"
                if [[ "$commit_ahead" -ne "0" && "$commit_behind" -ne "0" ]]; then
                    has_commit="+$commit_ahead/-$commit_behind"
                elif [[ "$commit_ahead" -ne "0" ]]; then
                    has_commit="$commit_ahead"
                elif [[ "$commit_behind" -ne "0" ]]; then
                    has_commit="-$commit_behind"
                fi
            fi
        fi

        local ret
        local shortstat # only to check for uncommitted changes
        shortstat="$(LC_ALL=C \git diff --shortstat HEAD 2>/dev/null)"

        if [[ -n "$shortstat" ]]; then
            local u_stat # shorstat of *unstaged* changes
            u_stat="$(LC_ALL=C \git diff --shortstat 2>/dev/null)"
            u_stat=${u_stat/*changed, /} # removing "n file(s) changed"

            local i_lines # inserted lines
            if [[ "$u_stat" = *insertion* ]]; then
                i_lines=${u_stat/ inser*}
            else
                i_lines=0
            fi

            local d_lines # deleted lines
            if [[ "$u_stat" = *deletion* ]]; then
                d_lines=${u_stat/*\(+\), }
                d_lines=${d_lines/ del*/}
            else
                d_lines=0
            fi

            local has_lines
            has_lines="+$i_lines/-$d_lines"

            if [[ -n "$has_commit" ]]; then
                # Changes to commit and commits to push
                ret="$PCOLOR_CHANGES${branch}$PRESET|$PCOLOR_DIFF$has_lines$PRESET,$has_commit"
            else
                ret="$PCOLOR_CHANGES${branch}$PRESET|$PCOLOR_DIFF$has_lines$PRESET" # changes to commit
            fi
        elif [[ -n "$has_commit" ]]; then
            # some commit(s) to push
            if [[ "$commit_behind" -gt "0" ]]; then
                ret="$PCOLOR_COMMITS_BEHIND${branch}$PRESET|$has_commit"
            else
                ret="$PCOLOR_COMMITS${branch}$PRESET|$has_commit"
            fi
        else
            ret="${branch}" # nothing to commit or push
        fi
        echo -nE " ($ret)"
    fi
}

__prompt_command() {
  local PERR="$?"
  PS1=""

  local PCOLOR_PAT="\[$(tput setaf 2)\]" #Green
  local PCOLOR_ROO="\[$(tput setaf 3)\]" #Yellow
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

  if (( EUID !=0 )); then
    local PPATH="$PCOLOR_PAT\W$PRESET"
  else
    local PPATH="$PCOLOR_ROO\W$PRESET"
  fi

  #prompt runtime
  local PRUNTIME="$PCOLOR_RUN$(_pruntime)$PRESET"

  #build prompt
  PS1+="$PRUNTIME"
  #prompt error
  if [ $PERR != 0 ]; then
    PS1+="$PCOLOR_ERR[$PERR]$PRESET"
  fi
  PS1+="\u$PHOST:$PPATH$(_pgit_branch_color)\\$ "

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
