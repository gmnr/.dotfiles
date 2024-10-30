# set ENV variables
export EDITOR=nvim
export VISUAL="$EDITOR"
export PAGER=bat
export DOTFILES=~/.dotfiles
export LEDGER_FILE=$HOME/.finance/all.journal
export BAT_CONFIG_DIR=~/.dotfiles/bat/
export CLICOLOR=1

# add path for npm
export PATH="/usr/local/opt/node@22/bin:$PATH"

# create dot folder for zsh
if [ -d ~/.config/zsh ]; then
  export ZDOTDIR=~/.config/zsh
else
  mkdir -p ~/.config/zsh
fi

# select correct locale
defaults write .GlobalPreferences AppleLocale en_IT
