#!/bin/zsh

# load file
zmodload zsh/datetime
current=~/.finance/prices/current_prices.journal
historic=~/.finance/prices/historic_prices.journal

# get timer of operation
read -r header < $current
strftime -r -s fetched '%Y-%m-%d %H:%M:%S' "${header#*@ }"
age=$(( EPOCHSECONDS - fetched ))
printf -v timer '%02dh%02dm' $(( age / 3600 )) $(( age / 60 % 60 ))

# price and delta vs the last historic snapshot, for every ticker, in one awk
read -r vwce delta_vwce iusa delta_iusa dot delta_dot alnz delta_alnz < <(
    tail -n 5 $historic | awk '
        $1 == "P" { gsub(",", ".", $NF); if (FILENAME == "-") old[$3] = $NF; else cur[$3] = $NF }
        END {
            n = split("VWCE IUSA DOT ALNZ", t, " ")
            for (i = 1; i <= n; i++) printf "%s %g ", cur[t[i]], cur[t[i]] - old[t[i]]
            print ""
        }' - $current | tr . ,
)

# expose calculation but shorten script if window length does not allow it
COLS=${1:-$(tmux display-message -p "#{client_width}")}
if [ $COLS -lt 120 ]
then
    echo "#[fg=#1f2335,bg=#e0af68,bold] $timer#[fg=#e0af68]#[fg=#3d59a1,bg=#e0af68]#[bg=#3d59a1,fg=colour255] $vwce#[fg=#3d59a1]#[fg=#449dab,bg=#3d59a1]#[bg=#449dab,fg=colour255] $iusa#[fg=#449dab]#[fg=#8c56bf,bg=#449dab]#[bg=#8c56bf,fg=colour255] $dot#[fg=#8c56bf]#[fg=#db4b4b,bg=#8c56bf]#[bg=#db4b4b,fg=colour255] $alnz"
else
    echo "#[fg=#1f2335,bg=#e0af68,bold] 󰚰 $timer#[fg=#e0af68]#[fg=#3d59a1,bg=#e0af68]#[bg=#3d59a1,fg=colour255] VWCE:$vwce  ∆:$delta_vwce#[fg=#3d59a1]#[fg=#449dab,bg=#3d59a1]#[bg=#449dab,fg=colour255] IUSA:$iusa  ∆:$delta_iusa#[fg=#449dab]#[fg=#8c56bf,bg=#449dab]#[bg=#8c56bf,fg=colour255] DOT:$dot  ∆:$delta_dot#[fg=#8c56bf]#[fg=#db4b4b,bg=#8c56bf]#[bg=#db4b4b,fg=colour255] ALNZ:$alnz  ∆:$delta_alnz"
fi
