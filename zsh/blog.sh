#!/bin/sh

# Set Session Name
SESSION="blog"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

# Only create tmux session if it doesn't already exist
if [ "$SESSIONEXISTS" = "" ]
then
    # Start New Session with our name
    tmux new-session -d -s $SESSION

    # Name first Pane and start zsh
    tmux rename-window -t $SESSION:1 'code'
    tmux send-keys -t $SESSION:1 'zsh' C-m 'clear' C-m 
    tmux send-keys -t $SESSION:1 'cd ~/.blog' C-M 'clear' C-m

    # setup Writing window
    tmux new-window -t $SESSION:2 -n 'writing'
    tmux send-keys -t $SESSION:2 'cd ~/.blog' C-M 'clear' C-m
    tmux send-keys -t $SESSION:2 "nvim" C-m

    # Create and setup pane for hugo server
    tmux new-window -t $SESSION:3 -n 'server'
    tmux send-keys -t $SESSION:3 'cd ~/.blog' C-M 'clear' C-m
    tmux send-keys -t $SESSION:3 'hugo server -D -F' C-m 

fi

# attach session
tmux attach-session -d -t $SESSION
