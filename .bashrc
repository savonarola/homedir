export PAGER="less"
export EDITOR="vim"
export VISUAL=$EDITOR
export PATH="$PATH:$HOME/.tools/";
export LESS="-MQR"

alias v="$EDITOR"
alias g="grep -i"
alias ll="ls -la"

bind '"\C-u"':kill-whole-line
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
bind '"\e[3~"':delete-char

# less
if [ "$UID" != 0 ]; then
    export LESSCHARSET="utf-8"
    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;31m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[01;44;33m'
    export LESS_TERMCAP_ue=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[01;32m'
fi

# Bash history
export HISTSIZE=50000
export HISTFILESIZE=5000000
export HISTFILE="$HOME/.bash_history_${HOSTNAME}"

set_prompts() {
    # Обычные цвета
    local DEFAULT="\[\033[0m\]"
    local BLACK="\[\033[0;30m\]"
    local RED="\[\033[0;31m\]"
    local GREEN="\[\033[0;32m\]"
    local YELLOW="\[\033[0;33m\]"
    local BLUE="\[\033[0;34m\]"
    local MAGENTA="\[\033[0;35m\]"
    local CYAN="\[\033[0;36m\]"
    local WHITE="\[\033[0;37m\]"

    # Bold
    local EM_BLACK="\[\033[1;30m\]"
    local EM_RED="\[\033[1;31m\]"
    local EM_GREEN="\[\033[1;32m\]"
    local EM_YELLOW="\[\033[1;33m\]"
    local EM_BLUE="\[\033[1;34m\]"
    local EM_MAGENTA="\[\033[1;35m\]"
    local EM_CYAN="\[\033[1;36m\]"
    local EM_WHITE="\[\033[1;37m\]"

    # Фон
    local BG_BLACK="\[\033[40m\]"
    local BG_RED="\[\033[41m\]"
    local BG_GREEN="\[\033[42m\]"
    local BG_YELLOW="\[\033[43m\]"
    local BG_BLUE="\[\033[44m\]"
    local BG_MAGENTA="\[\033[45m\]"
    local BG_CYAN="\[\033[46m\]"
    local BG_WHITE="\[\033[47m\]"

    PS1="${EM_GREEN}\u${EM_BLACK}@${EM_BLUE}\h ${EM_WHITE}\w${EM_BLUE}>${DEFAULT} "
    PS2="${EM_BLUE}>${DEFAULT} "
    PS3=$PS2
    PS4="${EM_BLUE}+${DEFAULT} "

    # Для рута
    if [ "$UID" = 0 ]; then
        PS1="${EM_BLACK}"'$?'"${EM_BLACK}[${EM_RED}\u${EM_BLACK}@${EM_CYAN}\h ${EM_RED}\w${EM_BLACK}]${EM_RED}\$${DEFAULT} "
        PS2="${EM_RED}>${DEFAULT} "
        PS3=$PS2
        PS4="${EM_RED}+${DEFAULT} "
    fi
#Кусок оригинально .bashrc от Debian 
    if [ -z "$debian_chroot" ] && [ -r "/etc/debian_chroot" ]; then
        export debian_chroot=`cat /etc/debian_chroot`
        PS1="${debian_chroot:+($debian_chroot)}${PS1}"
    fi

    export PS1 PS2 PS3 PS4
}
set_prompts
unset -f set_prompts

set bell-style visible

mesg n
umask 022

if tty -s; then
    stty -ixon
    stty -ixoff
fi

shopt -s cmdhist      \
         dotglob      \
         extglob      \
         histappend   \
         cdable_vars  \
         checkwinsize


    # Автодополнение
    complete -cf sudo
    complete -cf which
    complete -cf man
    if [ -r /etc/bash_completion ]; then
        . /etc/bash_completion
    fi

LOCAL="$HOME/.bashrc.local"

if [ -f $LOCAL ];
then
    source $LOCAL
fi

