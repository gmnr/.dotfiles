#!/bin/zsh
# open claude in a new tmux window
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.local/bin:$PATH"
base="$HOME/Downloads/01. Projects"

if [[ -z "${TMUX:-}" ]]; then
    echo "Claude: not inside a tmux session" >&2
    exit 1
fi

# First argument is a folder only if it's non-empty and doesn't start with "-"
if [[ $# -gt 0 && -n "$1" && "$1" != -* ]]; then
    dir="$base/$1"
    name="$(basename "$1")"
    shift
else
    [[ $# -gt 0 && -z "$1" ]] && shift   # drop an empty arg (e.g. from the tmux prompt)
    dir="$base"
    name="Claude"
fi

if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir" || exit 1
    tmux display-message "Claude: created $dir"
fi

# Remaining arguments (-c, -r, --model ..., etc.) go to claude
tmux new-window -c "$dir" -n "$name" claude "$@"
