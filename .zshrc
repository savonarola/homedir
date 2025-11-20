CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

# These files are a tiny part of some ancient version of https://github.com/ohmyzsh/ohmyzsh
#
# * Oh My Zsh is huge, I don't want to install it just for these few files
# * These excerpts are all I need
# * They are quite simple tweaks/functions, so there is no need to ever update them.
#
# So we just use them directly.
source $HOME/.zshrc.d/history.zsh
source $HOME/.zshrc.d/git.zsh
source $HOME/.zshrc.d/key-bindings.zsh
source $HOME/.zshrc.d/completion.zsh

source $HOME/.zshrc.d/prompt.zsh
# System configuration

ulimit -n 20480

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Path

export PATH="$PATH:$HOME/.tools"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.fzf/bin:$PATH"

if [ -d /opt/nvim-linux-x86_64/bin ]; then
    export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
fi

# Program setup

## Homebrew

BREW_PATH="/opt/homebrew/bin/brew"
if [ -f "$BREW_PATH" ]; then
    eval "$($BREW_PATH shellenv)"
    export HOMEBREW_NO_ENV_HINTS=1
fi

## Shell tools

if command -v nvim >/dev/null; then
    export EDITOR=nvim
    alias v="nvim"
else
    export EDITOR=vi
    alias v="vi"
fi

export PAGER=less
export LESS="-MQR"

## Erlang

export ERL_AFLAGS="-kernel shell_history enabled"

## Typst

[ -d "$HOME/Library/Fonts" ] && command -v typst >/dev/null && export TYPST_FONT_PATHS="$HOME/Library/Fonts"

## fdfind

if command -v fd >/dev/null; then
    FD_COMMAND="fd"
    alias fdi="fd -I -H"
elif command -v fdfind >/dev/null; then
    FD_COMMAND="fdfind"
    alias fd="fdfind"
    alias fdi="fdfind -I -H"
else
    FD_COMMAND=""
fi

## FZF
if [ -f "$HOME/.fzf.zsh" ]; then
    if [ -n "$FD_COMMAND" ]; then
        export FZF_DEFAULT_COMMAND="$FD_COMMAND --type file"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
    source "$HOME/.fzf.zsh"
fi

## ASDF

ASDF_SH="$HOME/.asdf/asdf.sh"
ASDF_BREW_SH="/opt/homebrew/opt/asdf/libexec/asdf.sh"
[ -f "$ASDF_SH" ] && source "$ASDF_SH"
[ -f "$ASDF_BREW_SH" ] && source "$ASDF_BREW_SH"

## Cargo

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

## Anaconda

ANACONDA_BREW_SH="/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
[ -f "$ANACONDA_BREW_SH" ] && source "$ANACONDA_BREW_SH"

## GCloud

GCLOUD_SDK_PATH="$HOME/google-cloud-sdk"

if [ -f "$GCLOUD_SDK_PATH/path.zsh.inc" ]; then source "$GCLOUD_SDK_PATH/path.zsh.inc"; fi
if [ -f "$GCLOUD_SDK_PATH/completion.zsh.inc" ]; then source "$GCLOUD_SDK_PATH/completion.zsh.inc"; fi

# Aliases

alias g='grep --color=auto'
alias h='history'

command -v rg >/dev/null && alias rgi="rg --no-ignore"
command -v lazygit >/dev/null && alias lg=lazygit
command -v bat >/dev/null && alias bat="$HOME/.cargo/bin/bat --style plain --paging never --theme 'Visual Studio Dark+'"
command -v exa >/dev/null && alias ll="exa --long --git --all"
command -v zoxide >/dev/null && eval "$(zoxide init zsh)" && alias cd=z
command -v prettyping >/dev/null && alias ping='prettyping --nolegend'

command -v kubectl >/dev/null && alias k=kubectl
command -v kubeoff >/dev/null && alias koff=kubeoff
command -v kubeon >/dev/null && alias kon=kubeon
command -v kubectx >/dev/null && alias kc=kubectx
command -v kubens >/dev/null && alias kn=kubens

# Helpers

function vscode-kill {
    ps aux | egrep '(.cursor-server|.vscode-server|erlang_ls)' | awk '{print $2}' | xargs kill
}

function wip {
    git add .
    git ci -m wip --no-verify
}

unalias gg 2>/dev/null

function gg {
    pattern="$1"
    git ls-files -m -o --exclude-standard | xargs rg --vimgrep "$pattern"
}

function grbr {
    if command -v fzf >/dev/null; then
        remote=$(git remote | fzf --height 40% --reverse)
        if [ -z "$remote" ]; then
            return 0
        fi
    else
        remote="$1"
        if [ -z "$remote" ]; then
            echo "Usage: grbr <remote_name>"
            return 1
        fi
    fi
    git for-each-ref --sort=-committerdate "refs/remotes/$remote" --format='%(committerdate:relative)%09%(align:left,30)%(refname:short)%(end)%09%(subject)'
}

function dsh {
    if [ $# -eq 0 ]; then
        if command -v fzf >/dev/null; then
            container=$(docker ps --format '{{.Names}} ({{.Image}})' | fzf --height 40% --reverse | cut -d' ' -f1)
            [ -n "$container" ] && docker exec -it "$container" bash
        else
            echo "Usage: dsh <container_name_or_id>"
            return 1
        fi
    else
        docker exec -it "$1" bash
    fi
}

function _kube_select_pod {
    if command -v fzf >/dev/null; then
        pod=$(kubectl get pods --no-headers | fzf --height 40% --reverse | awk '{print $1}')
        echo "$pod"
    else
        return 1
    fi
}

function ksh {
    if [ $# -eq 0 ]; then
        pod=$(_kube_select_pod)
        if [ -n "$pod" ]; then
            kubectl exec -it "$pod" -- /bin/bash
        else
            echo "Usage: ksh <pod_name>"
            return 1
        fi
    else
        kubectl exec -it "$1" -- /bin/bash
    fi
}

function kdesc {
    if [ $# -eq 0 ]; then
        pod=$(_kube_select_pod)
        if [ -n "$pod" ]; then
            kubectl describe pod "$pod"
        else
            echo "Usage: kdesc <pod_name>"
            return 1
        fi
    else
        kubectl describe pod "$1"
    fi
}

function klogs {
    if [ $# -eq 0 ]; then
        pod=$(_kube_select_pod)
        if [ -n "$pod" ]; then
            kubectl logs "$pod"
        else
            echo "Usage: klogs <pod_name>"
            return 1
        fi
    else
        kubectl logs "$1"
    fi
}

# SSH

function sshfix {
    VALID_SSH_SOCK=$(find /tmp/ssh*/ -type s -name "*agent.*" -printf '%T@ %p\n' | sort -nr | head -1 | cut -d' ' -f2)
    LINKED_SSH_SOCK="$HOME/.ssh/ssh_auth_sock"
    if [ -S "$VALID_SSH_SOCK" ] && { [ ! -L "$LINKED_SSH_SOCK" ] || [ ! -S "$LINKED_SSH_SOCK" ]; }; then
        ln -sf "$VALID_SSH_SOCK" "$LINKED_SSH_SOCK"
    fi
}

# Local configuration

LOCAL="$HOME/.zshrc.local"

if [[ -f $LOCAL ]];
then
    source $LOCAL
fi

