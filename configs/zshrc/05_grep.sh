alias g='grep --color=auto'

function back () {
    ack "$@" `bundle show --paths`
}

