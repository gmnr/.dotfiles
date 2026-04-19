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
    if [[ $MONTH -eq  12 ]] && [[ $DAY -lt 13 ]]
    then
        tmux new-session -d -s $SESSION "cd $ROOT/utils; python3 get_input.py; cd $ROOT/utils; cat $ROOT/$YEAR/$DAY/input.txt"
        tmux rename-window -t $SESSION 'advent'
        tmux split-window -t $SESSION -c "#{pane_current_path}"
        tmux new-window -t $SESSION -n 'coding' "nvim $ROOT/$YEAR/$DAY.py"

    else
        tmux rename-window -t $SESSION 'advent'
        tmux new-session -d -s $SESSION "cd $ROOT; git status"
        tmux new-window -t $SESSION -n 'coding' "cd $ROOT; nvim"
    fi
fi

# attach session
tmux switch-client -t $SESSION
