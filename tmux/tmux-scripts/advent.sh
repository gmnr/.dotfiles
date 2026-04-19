#!/bin/zsh

# Set Session Name
SESSION="advent"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

ROOT="${HOME}/Documents/advent-of-code/"
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
DAY=$(date +"%d")
URL_DAY=$(date +"%-d")

# Only create tmux session if it doesn't already exist
if [[ "$SESSIONEXISTS" = "" ]]
then
    # Start New Session with our name
    tmux new-session -d -s $SESSION

    if [[ $MONTH -eq  12 ]] && [[ $DAY -lt 13 ]]
    then
        tmux rename-window -t $SESSION 'advent'
        tmux send-keys -t $SESSION "cd ~/Documents/advent-of-code/utils" C-M 'clear' C-M
        tmux send-keys -t $SESSION "python3 get_input.py" C-M 'clear' C-M
        tmux send-keys -t $SESSION "cat $ROOT/$YEAR/$DAY/input.txt" C-M
        tmux split-window -t $SESSION
        tmux send-keys -t $SESSION "cd $ROOT/$YEAR/$DAY" C-M 'clear' C-M

        tmux new-window -t $SESSION -n 'coding'
        tmux send-keys -t $SESSION "nvim $ROOT/$YEAR/$DAY.py" C-M

    else
        tmux rename-window -t $SESSION 'advent'
        tmux send-keys -t $SESSION "cd ~/Documents/advent-of-code/" C-M 'clear' C-M
        tmux send-keys -t $SESSION "git status" C-M
        tmux new-window -t $SESSION -n 'coding'
        tmux send-keys -t $SESSION "cd $ROOT" C-M 'clear' C-M
        tmux send-keys -t $SESSION "nvim" C-M
    fi
fi

# attach session
tmux switch-client -t $SESSION
