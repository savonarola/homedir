# Oh My Zsh Start ##############################

export ZSH=$HOME/.oh-my-zsh
CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git history)

source $ZSH/oh-my-zsh.sh

# Oh My Zsh End ################################

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='%B%T%b %{$fg[red]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%} ${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_AHEAD="↑"
ZSH_THEME_GIT_PROMPT_DELETED="×"
ZSH_THEME_GIT_PROMPT_DIVERGED="→←"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="➜"
ZSH_THEME_GIT_PROMPT_STASHED="•"
ZSH_THEME_GIT_PROMPT_UNMERGED="↓"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"

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
