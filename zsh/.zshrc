# improve performance
autoload -U zmv
setopt extended_glob

# set autocompletion
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# enable vi mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# prompt
function parse_git_dirty() {
      [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
  }

function parse_git_branch() {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ <\1$(parse_git_dirty)> /"
  }

setopt PROMPT_SUBST
PROMPT='%B%F{green} %~%f %F{cyan}$(parse_git_branch)%f%F{red}>%f%b '

# functions
# open p7m
function decrypt() {
  openssl cms -decrypt -in "$1" -inform DER -verify -noverify -out "${1%.p7m*}"
}

# create dir and move into it
function mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

# cerate temp dir
function tempe () {
  cd "$(mktemp -d -p /tmp)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}

# helper functions !! with colors !!
function is() {
  clear;
  hledger is -p thismonth "$@" | ~/.dotfiles/hledger/scripts/colorize-report.py report
}

function iss() {
  clear;
  hledger is -3 "$@" | ~/.dotfiles/hledger/scripts/colorize-report.py report
}

function bs() {
  clear;
  hledger bs "$@" | ~/.dotfiles/hledger/scripts/colorize-report.py report
}

function reg() {
  clear;
  hledger reg -p thismonth -w $COLUMNS "$@" | ~/.dotfiles/hledger/scripts/colorize-report.py register
}

function regg() {
  clear;
  hledger reg -w $COLUMNS "$@" | ~/.dotfiles/hledger/scripts/colorize-report.py register
}

function areg() {
  clear;
  hledger areg -p thismonth -w $COLUMNS "$@" | ~/.dotfiles/hledger/scripts/colorize-report.py areg
}

function aregg() {
  clear;
  hledger areg -w $COLUMNS "$@" | ~/.dotfiles/hledger/scripts/colorize-report.py areg
}

function bal() {
  clear;
  hledger bal "$@" | ~/.dotfiles/hledger/scripts/colorize-report.py register
}

function out() {
  clear;
  hledger bal cash fineco -p thismonth -D --transpose -T amt:"<0" --drop 1 "$@" | ~/.dotfiles/hledger/scripts/colorize-report.py cf
}

function pvt() {
  clear;
  hledger is --pivot payee -p thismonth "$@" | ~/.dotfiles/hledger/scripts/colorize-report.py pivot
}

# open git
function run_git() {
  if [[ $# -gt 0 ]] then
    git $@
  else
    nvim +"vert Git"
  fi
}

# aliases
# folder
alias dot='cd ~/.dotfiles'
alias blog='cd ~/.blog'
alias finance='cd ~/.finance'
alias aocd='cd ~/Documents/advent-of-code'
alias sql='cd ~/Library/DBeaverData/workspace6/Terme/Scripts && run_git'
alias ..='cd ..'
alias ...='cd ../..'

# colors on ls
alias ls='eza --all --git-ignore'
alias ll='eza --long --header --all --git --sort=modified --reverse'

# advent of code utilities
alias aoc='~/Documents/advent-of-code/utils/startup.sh'

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
alias g='run_git'

# ledger aliases
alias hl='hledger'
alias hlp='hledger print'
alias e='nvim +$ ~/.finance/periods/2025.journal'
alias pp='python3 ~/.dotfiles/hledger/scripts/fetch-mkt-prices.py && python3 ~/.dotfiles/hledger/scripts/capital-gain-taxes.py'
alias prices='cat ~/.finance/prices/current_prices.journal'

# kmonad
alias qq='sudo killall kmonad && ~/.dotfiles/kmonad/startup.sh 1'
alias ww='sudo killall kmonad && ~/.dotfiles/kmonad/startup.sh 2'
alias QQ='sudo killall kmonad'
