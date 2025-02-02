#! /bin/bash

# `zellij list-sessions` output:
# awesome-mouse [Created 20s ago]
# polite-diplodocus [Created 6s ago]

sessions=$(zellij list-sessions | cut -d ' ' -f1)
local count=$(echo "$sessions" | wc -l)

if [ -z "$sessions" ]; then
    # No sessions exist, start a new one
    exec zellij
elif [ "$count" -eq 1 ]; then
    # Only one session exists, attach to it
    session_name=$(echo "$sessions" | cut -d ' ' -f1)
    exec zellij attach "$session_name"
else
    # Multiple sessions, let user select with fzf
    if command -v fzf >/dev/null; then
        session=$(echo "$sessions" | fzf --height 40% --reverse)

        if [ -n "$session" ]; then
            session_name=$(echo "$session" | cut -d ' ' -f1)
            exec zellij attach "$session_name"
        fi
    else
        echo "Multiple sessions exist. Use 'zellij attach <session>'"
        echo "Available sessions:"
        echo "$sessions"
        return 1
    fi
fi
