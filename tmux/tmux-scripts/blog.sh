#!/bin/zsh

# Set Session Name
SESSION="blog"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

# Only create tmux session if it doesn't already exist
if [[ "$SESSIONEXISTS" = "" ]]
then
    # Start New Session with our name
    tmux new-session -d -s $SESSION

    # start server
    tmux rename-window -t $SESSION 'server'
    tmux send-keys -t $SESSION 'cd ~/.blog' C-M 'clear' C-M
    tmux send-keys -t $SESSION 'hugo server -D -F' C-M
    tmux split-window -t $SESSION
    tmux send-keys -t $SESSION 'cd ~/.blog' C-M 'clear' C-M

    # setup editing window
    tmux new-window -t $SESSION -n 'coding'
    tmux send-keys -t $SESSION 'cd ~/.blog' C-M 'clear' C-M
    tmux send-keys -t $SESSION "nvim" C-M

fi

# attach session
tmux switch-client -t $SESSION
