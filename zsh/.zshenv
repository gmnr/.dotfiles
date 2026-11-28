# set ENV variables
export EDITOR=nvim
export VISUAL="$EDITOR"
export PAGER=bat
export DOTFILES=~/.dotfiles
export ICLOUD=~/Library/Mobile\ Documents/com~apple~CloudDocs
export LEDGER_FILE=$HOME/.finance/all.journal
export BAT_CONFIG_DIR=$DOTFILES/bat/
export CLICOLOR=1
export LESSHISTFILE=-

# dot folder for zsh
[ -d ~/.config/zsh ] || mkdir -p ~/.config/zsh
export ZDOTDIR=~/.config/zsh
