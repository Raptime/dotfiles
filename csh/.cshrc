#
# .cshrc - csh resource script, read at beginning of execution by each shell
#

alias h         history 25
alias j         jobs -l
alias ls        ls -GF
alias l         ls -l
alias la        l -a
alias ll        l -A
alias lh        l -h

# A righteous umask
umask 22

set path = (/sbin /bin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin $HOME/bin)

setenv  LANG     en_US.UTF-8
setenv  LANGUAGE en_US.UTF-8
setenv  LC_ALL   en_US.UTF-8

setenv  PAGER   less
setenv  BLOCKSIZE       K
setenv  EDITOR vi

if ($?prompt) then
        # An interactive shell -- set some stuff up
        set prompt="%{\e[0;34m%}[%{\e[0m%}%N@%m %~%{\e[0;34m%}]%{\e[0m%}%# "
        set promptchars = "%#"
        set filec
        set autolist = ambiguous
        set history = 1000
        set savehist = (1000 merge)
        # Use history to aid expansion
        set autoexpand
        set autorehash
        set mail = (/var/mail/$USER)
        if ( $?tcsh ) then
                bindkey "^W" backward-delete-word
                bindkey -k up history-search-backward
                bindkey -k down history-search-forward
                bindkey "\e[1~" beginning-of-line       # Home
                bindkey "\e[2~" overwrite-mode          # Insert
                bindkey "\e[3~" delete-char             # Delete
                bindkey "\e[4~" end-of-line             # End
                bindkey "\e[5~" history-search-backward # Page Up
                bindkey "\e[6~" history-search-forward  # Page Down
                bindkey "\eOc"  forward-word            # ctrl right
                bindkey "\eOd"  backward-word           # ctrl left
        endif
endif

