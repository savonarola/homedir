__distribution="Debian" #Адаптирует конфиг под Debian   

#Переменные для mpc
#export MPD_HOST="192.168.10.5"
#export MPD_PORT="6600"

#Остальные переменные
#-----------------------------------------------------------------------------
#Выходит из рута если неактивен в течении N секунд
[ "$UID" = 0 ] && export TMOUT=180

export PAGER="less"
export EDITOR="vim"
export VISUAL=$EDITOR
if [ "$UID" != 0 ]; then
    export XPAGER=$PAGER
    export XEDITOR="jedit"
fi

bind '"\C-u"':kill-whole-line
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
bind '"\e[3~"':delete-char


# less
export LESS="-MWi -x4 --shift 5"
export LESSHISTFILE="-"     # no less history file
if [ "$UID" != 0 ]; then
    export LESSCHARSET="utf-8"
    if [ -z "$LESSOPEN" ]; then
        if [ "$__distribution" = "Debian" ]; then
            [ -x "`which lesspipe`" ] && eval "$(lesspipe)"
        else
            [ -x "`which lesspipe.sh`" ] && export LESSOPEN="|lesspipe.sh %s"
        fi
    fi
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
export HISTFILESIZE=50000
export HISTFILE="$HOME/.bash_history_${HOSTNAME}"
if [ "$UID" != 0 ]; then
    export HISTCONTROL="ignoreboth"  
    export HISTIGNORE="[bf]g:exit:logout"
fi

# dircolors
if [ -s "$HOME/.dircolors" ]; then
    eval "`dircolors -b $HOME/.dircolors`"
else
    eval "`dircolors -b`"
fi


# Java
if [ "$__distribution" = "Debian" ]; then
    export JAVA_HOME="/usr/lib/jvm/java-6-sun"
fi


# Ctrl+D дважды для loguot 
export IGNOREEOF=1

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
alias ls="ls $LS_OPTIONS"
alias l="ls -l"
alias ll="ls -l"
alias la="ls -lA"
alias lh="ls -lh"
alias lah="ls -lAh"
alias p="$PAGER"
alias e="$EDITOR"
alias v="$EDITOR"
alias vi="vim"
alias nano="nano -w"
alias mc="mc -b"


if [ "$UID" = 0 ]; then
    return 0
fi


# ------------- Дальше для простых смертных (пользователей) --------------


if [ "$DISPLAY" ]; then
    alias p="$XPAGER"
    alias e="$XEDITOR"
fi

alias cd="cdpushd >/dev/null"
alias b="popd >/dev/null"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias cp="cp -i"   
alias mv="mv -i"  
alias rm="rm -i" 
alias mkdir="mkdir -p"
alias co="chown"
alias cm="chmod"
alias g="grep -i"
alias df="df -hT"
alias du="du -hsc"
alias free="free -m"
alias ps="ps -efH"
alias psr="ps -U root -u root u"
alias top="htop"
alias m="mount | column -t 2>/dev/null"
alias f="find | grep"       
alias path='echo -e ${PATH//:/\\n}'
alias dirs="dirs -v"
alias jobs="jobs -l"

#alias irs="LANG=ru_RU.KOI8-R irssi"

alias s="sudo"
alias ss="sudo -s"

alias openports="netstat -nape --inet"
alias myip="curl www.whatismyip.org"
alias ping="ping -c 4"
alias ns="netstat -alnp --protocol=inet | grep -v CLOSE_WAIT | cut -c-6,21-94 | tail"
alias ns2="sudo watch -n 3 -d -t netstat -vantp"
alias scp="scp -pr"
alias wget="wget -c"

alias startx="exec startx"
alias dosbox="dosbox -conf $HOME/.dosboxrc"
alias clam="clamscan --bell -i"
alias mp="mplayer"
alias cdt="eject -T"     

alias resetresolution="xrandr --size 1680x1050"
alias resetgamma="xgamma -gamma 1.0"

alias mute="amixer -q set Front toggle"
alias unmute="mute"

# Немного виндовых привычек :)
alias cls="clear"
alias ipconfig="ifconfig"
#alias chdir="cd"
#alias dir="ls -l"
#alias copy="cp"
#alias xcopy="cp -r"
#alias move="mv"
#alias ren="mv"
#alias del="rm"
#alias deltree="rm -r"
#alias md="mkdir -p"
#alias rd="rmdir"
#alias mem="free -m"

#Разукрашиваемся ;)
if which grc &>/dev/null; then
    alias .cl='grc -es --colour=auto'
    alias configure='.cl ./configure'
    alias diff='.cl diff'
    alias make='.cl make'
    alias gcc='.cl gcc'
    alias g++='.cl g++'
    alias ld='.cl ld'
    alias netstat='.cl netstat'
    alias ping='.cl ping -c 10'
    alias traceroute='.cl traceroute'
fi

# Помните переменную?
case "$__distribution" in
    ArchLinux)
        alias ,="pacman"
        alias ,l="pacman -Q"         
        alias ,ll="pacman -Ql"       
        alias ,o="pacman -Qo"       
        alias ,?="pacman -Si"       
        alias ,??="pacman -Qi"      
        alias ,s="pacsearch"         
        alias ,u="sudo pacman -Sy"   
        alias ,uu="sudo pacman -Syu"
        alias ,i="sudo pacman -S"    
        alias ,ii="sudo pacman -U"   
        alias ,r="sudo pacman -Rs"   
        alias ,p="sudo pacman -Rns"  

        # :D
        alias icanhas="sudo pacman -S"
        alias donotwant="sudo pacman -Rs"

        # yaourt 
        alias yr="yaourt"
        alias yrl="yaourt -Q"
        alias yrll="yaourt -Ql"
        alias yro="yaourt -Qo"
        alias yr?="yaourt -Si"
        alias yr??="yaourt -Qi"
        alias yrs="yaourt -Ss"
        alias yru="yaourt -Sy"
        alias yruu="yaourt -Syu --aur"   
        alias yri="yaourt -S"
        alias yrii="yaourt -U"
        alias yrr="yaourt -Rs"
        alias yrp="yaourt -Rns"
        alias yrg="yaourt -G"   

        #Цветастый поиск
        pacsearch() {
            echo -e "$(pacman -Ss $@ | sed \
            -e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
            -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
            -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
            -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
        }
    ;;
    Debian)
        alias ,="aptitude"
        alias ,,="apt-get"
        alias ,,,="dpkg"
        alias ,l="dpkg -l"
        alias ,ll="dpkg -L"
        alias ,o="dpkg -S"
        alias ,?="aptitude show"
        alias ,??="dpkg -p"
        alias ,s="aptitude search"
        alias ,u="sudo aptitude update"
        alias ,uu="sudo aptitude update && sudo aptitude safe-upgrade"
        alias ,uuu="sudo aptitude update && sudo aptitude full-upgrade"
        alias ,i="sudo aptitude install"
        alias ,ii="sudo dpkg -i"
        alias ,r="sudo aptitude remove"
        alias ,p="sudo aptitude purge"

        # :D
        alias icanhas="sudo aptitude install"
        alias donotwant="sudo aptitude remove"

        debian_listreconfigurable() {
            ls /var/lib/dpkg/info/*.templates | xargs -n 1 basename | sed -e "s/.templates$//"
        }
    
        debian_purge() {
            local pkgs="`dpkg -l | grep ^rc | cut -d' ' -f3`"
            if [ ! -z "$pkgs" ]; then
                echo "Эти пакеты будут удалены но конфиги остануться:"
                echo "$pkgs"
                echo -n "Точно удалить? [Y/n] "
                read -n 1 choice
                if [ -z "$choice" ] || [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
                        echo "$pkgs" | xargs sudo aptitude purge
                fi
            else
                echo "Нет пакетов."
            fi
        }
    ;;
esac


cdpushd() {
    if [ -n "$1" ]; then
        pushd "$*"
    else
        if [ "`pwd`" != "$HOME" ]; then
            pushd ~
        fi
    fi
}

# Бекап (пока эспериментальный)
# Использовать так: bak <file(s)/dir(s)>
bak() {
    bakdir="$HOME/.backup"

    [ ! -d "$bakdir" ] && mkdir -p -m 700 "$bakdir"

    for f in "$@"; do
        f="`echo "$f" | sed 's!/\+$!!'`"   
        command cp -ai "$f" "$HOME/.backup/$f.bak`date +'%Y%m%d%H%M'`"
    done
}

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

# Управление screen'ом
# Использовать так: 'screen' выведет список открытых скринов,'screen <name>' переводит в скрин с именем <name>,'screen <name>' создает скрин с именем <name>
screen() {
    if ! which screen &>/dev/null; then
        echo "${FUNCNAME[0]}(): You must install 'screen' first."
        return 1
    fi

    if [ "$1" ]; then
        command screen -D -R -a -A -S $HOSTNAME.$1
    else
        command screen -ls
        echo "To reattach a running session, type 'screen <sessionname>'"
    fi
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

# Устанавливает "стандартные" права (644/755), рекурсивно
# Использовать так: resetp <files/dirs>
resetp() {
    chmod -R u=rwX,go=rX "$@"
}

#Напоминалка 
# Использовать так:   remindme <time> <text>
# Пример: remindme 10m "omg, the pizza"
remindme() {
    if which zenity &>/dev/null; then
        echo "${FUNCNAME[0]}(): You must install 'zenity' first."
        return 1
    fi

    sleep "$1" && zenity --info --text "$2" &
}

# Скриншот
# Использовать так: screenshot [seconds delay] [quality]
screenshot() {
    if ! which scrot &>/dev/null; then
        echo "${FUNCNAME[0]}(): You must install 'scrot' first."
        return 1
    fi

    local delay=10
    local quality=95

    [ "$1" ] && delay="$1"
    [ "$2" ] && quality="$2"

    scrot -q $quality -d $delay "$HOME/screenshot_`date +'%F'`.jpg"
}


export LESS='-MQR'
PROMPT_COMMAND="bash_prompt.pl"
export PATH="$PATH:/home/savonarola/.tools/";


#-----------------------------------------------------------------------------
# Автостарт
#-----------------------------------------------------------------------------
# Выводит инфу о системе
#echo -e "\nuptime: `uptime | cut -b 14-27`"
#echo -e "\nlast:"
#last -3 | head -n $(expr $(last -3 | wc -l) - 2)

# fortune
#if which fortune &>/dev/null; then
#    echo -e "\n------------------------------------------------------------------------------\n"
#    fortune -a
#    echo -e "\n------------------------------------------------------------------------------\n"
#fi

# Это должно быть в конце:
# Стартует Х11 автоматом..
#if [ -z "$DISPLAY" ]; then
#    tty="`tty`"
#    for t in "/dev/vc/1" "vc/1" "/dev/tty1" "tty1"; do
#        if [ "$tty" = "$t" ]; then
#            n=2
#            echo "Исксы запустятся через $n сукунд ... Ctrl+C для отмены ..."
#            echo
#            sleep $n
#            exec startx
#        fi
#    done
#fi
#-----------------------------------------------------------------------------
