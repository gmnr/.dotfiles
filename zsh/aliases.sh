# aliases
# navigation
alias dot='cd ~/.dotfiles'
alias blog='cd ~/.blog'
alias finance='cd ~/.finance'
alias sql='cd ~/Library/DBeaverData/workspace6/Terme/Scripts && run_git'
alias ..='cd ..'
alias ...='cd ../..'

# colors on ls
alias ls='eza --all --git-ignore'
alias ll='eza --long --header --all --git --sort=modified --reverse'

# advent of code utilities
alias aoc='~/Documents/advent-of-code/utils/startup.sh'
alias aocd='cd ~/Documents/advent-of-code'

# rename programs
alias python='/usr/bin/python3'
alias pip='/usr/bin/pip3'
alias less='less -R'
alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'
alias upd='brew update && brew upgrade && nvim +"lua require(\"lazy\").sync()"'
alias cat='bat --style="numbers,changes,header" --italic-text=always'
alias rg='rg -S'
alias fd='fd -H -E .git'
alias n='nvim'
alias copy='pbcopy'
alias pasta='pbpaste'
alias cpwd='pwd | tr -d '\n' | copy'
alias g='git'
alias gg='nvim +"vert Git"'

# kmonad
alias qq='sudo killall kmonad && ~/.dotfiles/kmonad/startup.sh 1'
alias ww='sudo killall kmonad && ~/.dotfiles/kmonad/startup.sh 2'
alias QQ='sudo killall kmonad'
