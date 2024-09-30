# run kmonad for both "main" keyboards
if [[ $1 -eq 1 ]]; then
  sudo kmonad ~/.dotfiles/kmonad/apple.kbd &
  sudo kmonad ~/.dotfiles/kmonad/kinesis.kbd &
fi

# run kmonad for additional keyboard
if [[ $1 -eq 2 ]]; then
  sudo kmonad ~/.dotfiles/kmonad/fujitsu.kbd &
fi
