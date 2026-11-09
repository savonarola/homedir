autoload -U colors && colors
setopt prompt_subst

local ret_status="%(?:%{$fg_bold[green]%}>:%{$fg_bold[red]%}>)"

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}*"

ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" %{$fg[yellow]%}B%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" %{$fg[yellow]%}A%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=" %{$fg_bold[red]%}D%{$reset_color%}"

function prompt_host() {
    local host=${PROMPT_HOST-${HOST%%.*}}
    print -rn -- "${host//\%/%%}"
}

function prompt_path() {
    local display_path=${(%):-%~}
    local branch=''
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
        branch=$(git_current_branch)
    fi

    local directory_color="%{$fg_bold[white]%}"
    local branch_color=${ZSH_THEME_GIT_PROMPT_PREFIX# }
    local reset="%{$reset_color%}"
    if [[ -n "$branch" && "$branch" == "${PWD:t}" && "${display_path:t}" == "$branch" ]]; then
        local parent=${display_path%${display_path:t}}
        print -rn -- "${directory_color}${parent//\%/%%}${branch_color}${branch//\%/%%}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
    else
        print -rn -- "${directory_color}${display_path//\%/%%}${reset}"
        if [[ -n "$branch" ]]; then
            print -rn -- "${ZSH_THEME_GIT_PROMPT_PREFIX}${branch//\%/%%}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
        fi
    fi
}
