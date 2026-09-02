#!/bin/zsh

# load file
src=`cat ~/.finance/prices/current_prices.journal`
old=`tail -n 5 ~/.finance/prices/historic_prices.journal`

# get timer of operation
run_time=`echo $src | grep "\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d" --color=no -o`
run_time_seconds=`date -j -f '%Y-%m-%d %H:%M:%S' "$run_time" '+%s'`
now=`date '+%s'`

diffSeconds="$(($now-$run_time_seconds))"
timer=`echo $diffSeconds | awk '{printf "%02dh%02dm", $1/3600, ($1/60)%60}'`

# get prices and old prices
vwce=`echo $src | grep "VWCE \d*,\d\d" --color=no -o | cut -d ' ' -f 2 | tr ',' '.'`
iusa=`echo $src | grep "IUSA \d*,\d\d" --color=no -o | cut -d ' ' -f 2 | tr ',' '.'`
dot=`echo $src | grep "DOT \d*,\d\d" --color=no -o | cut -d ' ' -f 2 | tr ',' '.'`
alnz=`echo $src | grep "ALNZ \d*,\d\d\d" --color=no -o | cut -d ' ' -f 2 | tr ',' '.'`
old_vwce=`echo $old | grep "VWCE \d*,\d\d" --color=no -o | cut -d ' ' -f 2 | tr ',' '.'`
old_iusa=`echo $old | grep "IUSA \d*,\d\d" --color=no -o | cut -d ' ' -f 2 | tr ',' '.'`
old_dot=`echo $old | grep "DOT \d*,\d\d" --color=no -o | cut -d ' ' -f 2 | tr ',' '.'`
old_alnz=`echo $old | grep "ALNZ \d*,\d\d\d" --color=no -o | cut -d ' ' -f 2 | tr ',' '.'`

# echo "$vwce $old_vwce" | awk '{print $1-$2}'
delta_vwce=`echo "$vwce $old_vwce" | awk '{print $1-$2}'`
delta_iusa=`echo "$iusa $old_iusa" | awk '{print $1-$2}'`
delta_dot=`echo "$dot $old_dot" | awk '{print $1-$2}'`
delta_alnz=`echo "$alnz $old_alnz" | awk '{print $1-$2}'`

vwce=`echo $vwce | tr '.' ','`
iusa=`echo $iusa | tr '.' ','`
dot=`echo $dot | tr '.' ','`
alnz=`echo $alnz | tr '.' ','`
delta_vwce=`echo $delta_vwce | tr '.' ','`
delta_iusa=`echo $delta_iusa | tr '.' ','`
delta_dot=`echo $delta_dot | tr '.' ','`
delta_alnz=`echo $delta_alnz | tr '.' ','`

# expose calculation but shorten script if window length does not allow it
COLS=$(tmux display-message -p "#{client_width}")
if [ $COLS -lt 120 ]
then
    echo "#[fg=#1f2335,bg=#e0af68,bold] $timer#[fg=#e0af68]#[fg=#3d59a1,bg=#e0af68]#[bg=#3d59a1,fg=colour255] $vwce#[fg=#3d59a1]#[fg=#449dab,bg=#3d59a1]#[bg=#449dab,fg=colour255] $iusa#[fg=#449dab]#[fg=#db4b4b,bg=#449dab]#[bg=#db4b4b,fg=colour255] $dot#[fg=#db4b4b]#[fg=#8c56bf,bg=#db4b4b]#[bg=#8c56bf,fg=colour255] $alnz"
else
    echo "#[fg=#1f2335,bg=#e0af68,bold] 󰚰 $timer#[fg=#e0af68]#[fg=#3d59a1,bg=#e0af68]#[bg=#3d59a1,fg=colour255] VWCE:$vwce  ∆:$delta_vwce#[fg=#3d59a1]#[fg=#449dab,bg=#3d59a1]#[bg=#449dab,fg=colour255] IUSA:$iusa  ∆$delta_iusa#[fg=#449dab]#[fg=#db4b4b,bg=#449dab]#[bg=#db4b4b,fg=colour255] DOT:$dot  ∆:$delta_dot#[fg=#db4b4b]#[fg=#8c56bf,bg=#db4b4b]#[bg=#8c56bf,fg=colour255] ALNZ:$alnz  ∆:$delta_alnz"
fi
