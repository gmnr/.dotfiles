#!/bin/zsh

# Set Session Name
SESSION="blog"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)
ROOT=$HOME/.blog

# Only create tmux session if it doesn't already exist
if [[ "$SESSIONEXISTS" = "" ]]
then
    tmux new-session -d -s $SESSION "cd $ROOT; hugo server -D -F"
    tmux split-window -t $SESSION:1 -c "#{pane_current_path}"
    tmux rename-window -t $SESSION 'server'

    # setup editing window
    tmux new-window -t $SESSION -n "coding" "cd $ROOT; nvim"
fi

# attach session
tmux switch-client -t $SESSION
