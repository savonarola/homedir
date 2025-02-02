autoload -U colors && colors

local ret_status="%(?:%{$fg_bold[green]%}>:%{$fg_bold[red]%}>)"
PROMPT='%B%T%b %{$fg[red]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[white]%}%~%{$reset_color%}$(git_prompt_info)$(git_remote_status) ${ret_status}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}*"

ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" %{$fg[yellow]%}B%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" %{$fg[yellow]%}A%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=" %{$fg_bold[red]%}D%{$reset_color%}"
