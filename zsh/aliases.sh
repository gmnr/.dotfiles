#!/bin/zsh
# aliases
# navigation
alias dot='cd ~/.dotfiles'
alias blog='~/.dotfiles/tmux/tmux-scripts/blog.sh'
alias finance='cd ~/.finance'
alias sql='cd ~/Library/DBeaverData/workspace6/Terme/Scripts && run_git'
alias ..='cd ..'
alias ...='cd ../..'

# colors on ls
alias ls='eza --all --header --git --git-ignore -I .gitignore'
alias ll='eza --long --header --all --git --sort=modified --reverse'

# advent of code utilities
alias aoc='~/.dotfiles/tmux/tmux-scripts/advent.sh'

# rename programs
alias python='/opt/homebrew/bin/python3'
alias pip='/opt/homebrew/bin/pip3'
alias less='less -R'
alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'
alias upd='brew update && brew upgrade && nvim +"lua require(\"lazy\").sync()"'
alias cat='bat --style="numbers,changes,header" --italic-text=always'
alias rg='rg -S --smart-case --hidden --iglob=!.git/'
alias fd='fd -H -E .git'
alias n='nvim'
alias copy='pbcopy'
alias pasta='pbpaste'
alias cpwd='pwd | tr -d '\n' | copy'
alias g='git'
alias gg='nvim +Neogit'

# kmonad
alias qq='sudo killall kmonad && ~/.dotfiles/kmonad/startup.sh 1'
alias ww='sudo killall kmonad && ~/.dotfiles/kmonad/startup.sh 2'
alias QQ='sudo killall kmonad'

# help
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}
