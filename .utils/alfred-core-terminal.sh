apps=( $(/usr/bin/lsappinfo metainfo | /usr/bin/grep bringForwardOrder | /usr/bin/grep -oE --color=never \".*?\" | /usr/bin/sed 's/ /\\/g') )

if [[ ${apps[0]} =~ '"Alacritty"' ]]; then
  previous=$(echo ${apps[1]} | /usr/bin/sed 's/\\/ /g' | tr -d '"')
  open -a "$previous"
else open -a "Alacritty"
fi
