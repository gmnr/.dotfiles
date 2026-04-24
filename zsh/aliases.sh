#!/bin/zsh
# aliases
# navigation
alias dot='cd ~/.dotfiles'
alias finance='cd ~/.finance'
alias sql='cd ~/.work_sql && run_git'
alias ..='cd ..'
alias ...='cd ../..'

# colors on ls
alias ls='eza --all --header --git --git-ignore -I .gitignore'
alias ll='eza --long --header --all --git --sort=modified --reverse'

# tmux session
alias aoc='~/.dotfiles/tmux/tmux-scripts/advent.sh'
alias blog='~/.dotfiles/tmux/tmux-scripts/blog.sh'

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
alias gg='nvim +"lua Snacks.lazygit()"'

# kmonad
alias kmd='cd ~/.dotfiles/keymaps/kmonad'
alias QQ='sudo killall kmonad'

# help
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}
