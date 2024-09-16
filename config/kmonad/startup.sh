# run kmonad for both "main" keyboards
if [[ $1 -eq 1 ]]; then
  sudo kmonad ~/.dotfiles/config/kmonad/apple.kbd &
  sudo kmonad ~/.dotfiles/config/kmonad/kinesis.kbd &
fi

# run kmonad for additional keyboard
if [[ $1 -eq 2 ]]; then
  sudo kmonad ~/.dotfiles/config/kmonad/fujitsu.kbd &
fi
