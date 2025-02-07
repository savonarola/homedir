#! /bin/bash

# `tmux list-sessions` output example:
# dev: 1 windows (created Thu Mar 21 10:00:00 2024)
# work: 2 windows (created Thu Mar 21 09:00:00 2024)

full_sessions=$(tmux list-sessions 2>/dev/null)
sessions=$(echo "$full_sessions" | cut -d ':' -f1)
count=$(echo "$sessions" | wc -l)

if [ -z "$sessions" ]; then
    # No sessions exist, start a new one
    exec tmux -CC
elif [ "$count" -eq 1 ]; then
    # Only one session exists, attach to it
    session_name="$sessions"
    exec tmux -CC attach-session -t "$session_name"
else
    # Multiple sessions, let user select with fzf
    if command -v fzf >/dev/null; then
        full_session=$(echo "$full_sessions" | fzf --height 40% --reverse)

        if [ -n "$full_session" ]; then
            session=$(echo "$full_session" | cut -d ':' -f1)
            exec tmux -CC attach-session -t "$session"
        fi
    else
        echo "Multiple sessions exist. Use 'tmux -CC attach-session -t <session>'"
        echo "Available sessions:"
        echo "$full_sessions"
        return 1
    fi
fi
