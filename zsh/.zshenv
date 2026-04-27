# set ENV variables
export EDITOR=nvim
export VISUAL="$EDITOR"
export PAGER=bat
export DOTFILES=~/.dotfiles
export LEDGER_FILE=$HOME/.finance/all.journal
export BAT_CONFIG_DIR=$HOME/.dotfiles/bat/
export CLICOLOR=1
export LESSHISTFILE=-

# zsh-vi-mode always start in insert mode
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

# create dot folder for zsh
if [ -d ~/.config/zsh ]; then
    export ZDOTDIR=~/.config/zsh
else
    mkdir -p ~/.config/zsh
fi

# select correct locale
defaults write .GlobalPreferences AppleLocale en_IT
