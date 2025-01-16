# run kmonad for "main" keyboard
if [[ $1 -eq 1 ]]; then
  sudo kmonad ~/.dotfiles/kmonad/m4.kbd &
fi

# run kmonad for additional keyboard
if [[ $1 -eq 2 ]]; then
  sudo kmonad ~/.dotfiles/kmonad/kinesis.kbd &
fi
