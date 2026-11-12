function kube_ps1 {
    command -v kubectl >/dev/null || return 0
    [[ "${KUBE_PS1_ENABLED:-on}" == off ]] && return 0
    [[ -z "$KUBE_PS1_ENABLED" && -f "$HOME/.kube/kube-ps1/disabled" ]] && return 0

    local context namespace
    context=$(kubectl config current-context 2>/dev/null) || return 0
    [[ -n "$context" ]] || return 0
    namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null) || return 0
    context=${context//\%/%%}
    namespace=${namespace//\%/%%}
    printf '(%%F{blue}⎈%%f|%%F{red}%s%%f:%%F{cyan}%s%%f)' "$context" "${namespace:-default}"
}

function kubeon {
    case "$1" in
        -g|--global)
            rm -f -- "$HOME/.kube/kube-ps1/disabled" || return
            ;;
        -h|--help)
            print -r -- 'Usage: kubeon [-g | --global] [-h | --help]'
            return 0
            ;;
        '') ;;
        *) return 1 ;;
    esac
    KUBE_PS1_ENABLED=on
}

function kubeoff {
    case "$1" in
        -g|--global)
            mkdir -p -- "$HOME/.kube/kube-ps1" || return
            touch -- "$HOME/.kube/kube-ps1/disabled" || return
            ;;
        -h|--help)
            print -r -- 'Usage: kubeoff [-g | --global] [-h | --help]'
            return 0
            ;;
        '') ;;
        *) return 1 ;;
    esac
    KUBE_PS1_ENABLED=off
}
