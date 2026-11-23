#!/bin/zsh
# aliases
# navigation
alias dot='cd "$DOTFILES"'
alias finance='cd ~/.finance'
alias sql='cd ~/.work_sql && run_git'
alias icloud='cd "$ICLOUD"'
alias ..='cd ..'
alias ...='cd ../..'

# colors on ls
alias ls='eza --git --git-ignore -I .gitignore --icons --group-directories-first --color=auto'
alias ll='eza --long --header --all --git --sort=modified --reverse --icons --group-directories-first --time-style=long-iso --color=auto'
alias tree='eza --tree --icons=auto --color=auto'

# tmux session
alias aoc='$DOTFILES/tmux/tmux-scripts/advent.sh'
alias blog='$DOTFILES/tmux/tmux-scripts/blog.sh'

# rename programs
alias pip='uv pip'  # python/python3 come from uv (~/.local/bin)
alias less='less -R'
alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'
alias df='df -h'
alias cat='bat --style="numbers,changes,header" --italic-text=always'
alias rg='rg --smart-case --hidden --iglob=!.git/'
alias fd='fd -H -E .git'
alias n='nvim'
alias cpy='pbcopy'
alias cpwd="pwd -P | tr -d '\n' | pbcopy"
alias g='run_git'

# help
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}
