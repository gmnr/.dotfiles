#!/bin/zsh

# expose calculation but shorten script if window length does not allow it
SESSION_NAME=$(tmux display-message -p "#{session_name}")
if [[ $SESSION_NAME == "advent" ]]
then
    echo "#f7768e"
elif [[ $SESSION_NAME == "blog" ]]
then
    echo "#9ece6a"
else
    echo "#7aa2f7"
fi
