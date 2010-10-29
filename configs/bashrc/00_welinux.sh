export PAGER="less"
export EDITOR="vim"
export VISUAL=$EDITOR

bind '"\C-u"':kill-whole-line
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
bind '"\e[3~"':delete-char

# less
export LESS="-MQR"
if [ "$UID" != 0 ]; then
    export LESSCHARSET="utf-8"
    # Цветные маны через less
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

#-----------------------------------------------------------------------------
# Misc Settings
#-----------------------------------------------------------------------------
setterm -blength 0
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

#
#PROMPT_COMMAND='history -a'
#
#if [ "$UID" != 0 ]; then
#    shopt -s cdspell    \

#   nocaseglob

  #shopt -u mailwarn

  #set -o notify

  #ulimit -S -c 0   # cf. 'man bash', not 'man ulimit'

    # Автодополнение
    complete -cf sudo
    complete -cf which
    complete -cf man
    if [ -r /etc/bash_completion ]; then
        . /etc/bash_completion
    fi


#-----------------------------------------------------------------------------
# Алиасы + дополнительные функции
#-----------------------------------------------------------------------------
alias l="ls -l"
alias ll="ls -lo --color=yes"
alias p="$PAGER"
alias e="$EDITOR"
alias v="$EDITOR"
alias vi="vim"


alias g="grep -i"

# Запустить команду в бекграунде и без вывода.
# Использовать так: nh <command>
nh() {
    nohup "$@" &>/dev/null &
}

# Создать директорию и скопировать/переместить файлы в нее
# Использовать так: cpd/mvd <file> <directory>
cpd() {
    [ ! -d "$2" ] && mkdir -p "$2"
    cp "$1" "$2"
}
mvd() {
    [ ! -d "$2" ] && mkdir -p "$2"
    mv "$1" "$2"
}


# Создает архив из директории
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# Распаковывает
# Использовать так: x <file>
x() {
    for prog in uncompress tar 7za unzip unrar unace tar gunzip bunzip2; do
        if ! which $prog &>/dev/null; then
            echo "${FUNCNAME[0]}(): Warning: Can't find program '$prog'."
        fi
    done

    local is_tgz=0
    local is_tbz2=0
    local n=""

    local ext="${1##*.}"
    local ext_lc="`echo $ext | tr [:upper:] [:lower:]`"

    case "$1" in
        *.tar.gz)  n="`echo "$1" | sed 's/\.tar\..\+$//'`"; is_tgz=1  ;;
        *.tar.bz2) n="`echo "$1" | sed 's/\.tar\..\+$//'`"; is_tbz2=1 ;;
        *)         n="${1%.*}"
    esac

    case "$ext_lc" in
        z)        uncompress "$1" ;;
        tar)      mkdir "$n"; mv "$1" "$n"; cd "$n"; tar xvf "$1" ; mv "$1" ..; cd .. ;;
        7z)       mkdir "$n"; mv "$1" "$n"; cd "$n"; 7za x "$1"   ; mv "$1" ..; cd .. ;;
        zip)      mkdir "$n"; mv "$1" "$n"; cd "$n"; unzip "$1"   ; mv "$1" ..; cd .. ;;
        rar)      mkdir "$n"; mv "$1" "$n"; cd "$n"; unrar x "$1" ; mv "$1" ..; cd .. ;;
        ace)      mkdir "$n"; mv "$1" "$n"; cd "$n"; unace x "$1" ; mv "$1" ..; cd .. ;;
        tgz)      mkdir "$n"; mv "$1" "$n"; cd "$n"; tar xvzf "$1"; mv "$1" ..; cd .. ;;
        tbz|tbz2) mkdir "$n"; mv "$1" "$n"; cd "$n"; tar xvjf "$1"; mv "$1" ..; cd .. ;;
        gz)
            if [ $is_tgz ]; then
                mkdir "$n"; mv "$1" "$n"; cd "$n"; tar xvzf "$1"; mv "$1" ..; cd ..
            else
                gunzip "$1"
            fi ;;
        bz2)
            if [ $is_tbz2 ]; then
                mkdir "$n"; mv "$1" "$n"; cd "$n"; tar xvjf "$1"; mv "$1" ..; cd ..
            else
                bunzip2 "$1"
            fi ;;
        *) echo "${FUNCNAME[0]}(): Can't extract: unknown file extension $ext"; return 1
    esac
}

PROMPT_COMMAND="bash_prompt.pl"
export PATH="$PATH:/home/savonarola/.tools/";

