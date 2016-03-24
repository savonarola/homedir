export LANG="ru_RU.UTF-8"
export LC_ALL="ru_RU.UTF-8"

export PATH="$PATH:$HOME/.tools"
export EDITOR=vim

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'

export PAGER=less
export LESS="-MQR"

umask 2

alias v="vim"
alias :e="vim"
alias gv="gvim"
alias g='grep --color=auto'
alias irb='irb --readline -r irb/completion'

alias dp="vsn patch bundle exec cap production release:deploy"
alias dmn="vsn minor bundle exec cap production release:deploy"
alias dmd="vsn middle bundle exec cap production release:deploy"
alias dmj="vsn major bundle exec cap production release:deploy"

alias f="sudo -u fbdeploy"
alias fs="f sudo -u service"

HISTFILE=~/.history
HISTSIZE=10500
SAVEHIST=10000
SHARE_HISTORY=1
EXTENDED_HISTORY=1
HIST_EXPIRE_DUPS_FIRST=1

# Grep the history with 'h'
h () { history 0 | grep $1 }

setopt prompt_subst
PROMPT='%B%T%b %{[00;31m%}%n%{[01;37m%}@%{[00;32m%}%m%{[00m%}:%~`git-prompt`%(!.#.>)'

alias pg='ps aux | g'

zstyle ':completion:*' completer _expand _complete

autoload -Uz compinit
compinit -u
autoload -Uz colors
colors

autoload -U select-word-style
select-word-style bash


# this one is very nice:
# cursor up/down look for a command that started like the one starting on the command line
function history-search-end {
    integer ocursor=$CURSOR

    if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
      # Last widget called set $hbs_pos.
      CURSOR=$hbs_pos
    else
      hbs_pos=$CURSOR
    fi

    if zle .${WIDGET%-end}; then
      # success, go to end of line
      zle .end-of-line
    else
      # failure, restore position
      CURSOR=$ocursor
      return 1
    fi
}

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

typeset -g -A key

key[F1]='^[OP'
key[F2]='^[OQ'
key[F3]='^[OR'
key[F4]='^[OS'
key[F5]='^[[15~'
key[F6]='^[[17~'
key[F7]='^[[18~'
key[F8]='^[[19~'
key[F9]='^[[20~'
key[F10]='^[[21~'
key[F11]='^[[23~'
key[F12]='^[[24~'
key[Backspace]='^?'
key[Insert]=''
key[Home]='^[[H'
key[PageUp]='^[[5~'
key[Delete]='^[[3~'
key[End]='^[[F'
key[PageDown]='^[[6~'
key[Up]='^[[A'
key[Left]='^[[D'
key[Down]='^[[B'
key[Right]='^[[C'
key[Menu]=''

bindkey "${key[Home]}" beginning-of-line
bindkey "${key[End]}" end-of-line

bindkey -e "\e[1~" beginning-of-line
bindkey -e "\e[4~" end-of-line
bindkey -e "\e[7~" beginning-of-line
bindkey -e "\e[8~" end-of-line
bindkey -e "\eOH" beginning-of-line
bindkey -e "\eOF" end-of-line
bindkey -e "\e[H" beginning-of-line
bindkey -e "\e[F" end-of-line
bindkey "^[[3~" delete-char

bindkey -e "${key[Up]}"  history-beginning-search-backward-end #cursor up
bindkey -e "${key[Down]}" history-beginning-search-forward-end  #cursor down

if [[ -x `which git 2> /dev/null` ]]; then

    function in_mnt_dir() {
        pwd | grep '/home/savonarola/mnt'
    }

    function git-branch-name () {
        git branch 2> /dev/null | grep '^\*' | sed 's/^\*\ //'
    }

    function git-prompt() {
        if [[ x$ngp = x ]]; then
            in_mnt_dir=$(in_mnt_dir)
            if [[ x$in_mnt_dir = x ]]; then
                branch=$(git-branch-name)
                if [[ x$branch != x ]]; then
                    color=$fg[cyan]
                    wc_status=""

                    gstatus=$(git status 2> /dev/null)

                    dirty=$(echo $gstatus | sed 's/^#.*$//' | tail -2 | grep 'working directory clean';)
                    if [[ x$dirty = x ]]; then
                        color=$fg[magenta]
                    fi

                    need_push=$(echo $gstatus | grep 'Your branch is ahead' 2> /dev/null)
                    if [[ x$need_push != x ]]; then
                        wc_status=" F"
                    fi

                    need_pull=$(echo $gstatus | grep 'Your branch is behind' 2> /dev/null) 
                    if [[ x$need_pull != x ]]; then
                        wc_status=" B"
                    fi

                    diverged=$(echo $gstatus | grep 'have diverged,' 2> /dev/null) 
                    if [[ x$diverged != x ]]; then
                        wc_status=" D"
                        color=$fg[red]
                    fi

                    echo " %{$color%}$branch$wc_status%{$reset_color%} "
                fi
            fi
        else
            echo ''
        fi
    }

    function git-prompt-off() {
        ngp='TRUE'
    }

    function git-prompt-on() {
        ngp=''
    }

fi

LOCAL="$HOME/.zshrc.local"

if [[ -f $LOCAL ]];
then
    source $LOCAL
fi

