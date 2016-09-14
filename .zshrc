# Oh My Zsh ##############################

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git )

source $ZSH/oh-my-zsh.sh

# Oh My Zsh ##############################

export LANG="ru_RU.UTF-8"
export LC_ALL="ru_RU.UTF-8"

export PATH="$PATH:$HOME/.tools"
export EDITOR=vim

export PAGER=less
export LESS="-MQR"

umask 2

alias v="vim"
alias :e="vim"
alias gv="gvim"
alias g='grep --color=auto'
alias irb='irb --readline -r irb/completion'
alias ll='ls -la --color=yes'

alias dp="vsn patch bundle exec cap production release:deploy"
alias dmn="vsn minor bundle exec cap production release:deploy"
alias dmd="vsn middle bundle exec cap production release:deploy"
alias dmj="vsn major bundle exec cap production release:deploy"

alias f="sudo -u fbdeploy"
alias fs="f sudo -u service"

LOCAL="$HOME/.zshrc.local"

if [[ -f $LOCAL ]];
then
    source $LOCAL
fi
