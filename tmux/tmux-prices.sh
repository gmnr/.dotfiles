#!/bin/bash

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
old_vwce=`echo $old | grep "VWCE \d*,\d\d" --color=no -o | cut -d ' ' -f 2 | tr ',' '.'`
old_iusa=`echo $old | grep "IUSA \d*,\d\d" --color=no -o | cut -d ' ' -f 2 | tr ',' '.'`
old_dot=`echo $old | grep "DOT \d*,\d\d" --color=no -o | cut -d ' ' -f 2 | tr ',' '.'`

# echo "$vwce $old_vwce" | awk '{print $1-$2}'
delta_vwce=`echo "$vwce $old_vwce" | awk '{print $1-$2}'`
delta_iusa=`echo "$iusa $old_iusa" | awk '{print $1-$2}'`
delta_dot=`echo "$dot $old_dot" | awk '{print $1-$2}'`

vwce=`echo $vwce | tr '.' ','`
iusa=`echo $iusa | tr '.' ','`
dot=`echo $dot | tr '.' ','`
delta_vwce=`echo $delta_vwce | tr '.' ','`
delta_iusa=`echo $delta_iusa | tr '.' ','`
delta_dot=`echo $delta_dot | tr '.' ','`

# expose calculation
echo "#[fg=#1f2335,bg=#7aa2f7,bold] UPD:$timer #[fg=colour255,bg=#3f51b5] VWCE:$vwce  $delta_vwce #[bg=#f44336] IUSA:$iusa  $delta_iusa #[bg=#e6007a] DOT:$dot  $delta_dot"
