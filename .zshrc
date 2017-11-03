# Oh My Zsh Start ##############################

export ZSH=$HOME/.oh-my-zsh
CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git history k)

source $ZSH/oh-my-zsh.sh

# Oh My Zsh End ################################

local ret_status="%(?:%{$fg_bold[green]%}>:%{$fg_bold[red]%}>)"
PROMPT='%B%T%b %{$fg[red]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[white]%}%~%{$reset_color%}$(git_prompt_info)$(git_remote_status) ${ret_status}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}*"

ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" %{$fg[yellow]%}B%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" %{$fg[yellow]%}A%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=" %{$fg_bold[red]%}D%{$reset_color%}"

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
