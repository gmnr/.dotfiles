# improve performance
autoload -U zmv
setopt extended_glob

# enable vi mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# prompt
function parse_git_dirty() {
      [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
  }

function parse_git_branch() {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/<\1$(parse_git_dirty)> /"
  }

setopt PROMPT_SUBST
PROMPT='%B%F{green} %~%f %F{cyan}$(parse_git_branch)%f%F{red}>%f%b '

# functions
# open p7m
function p7m() {
  openssl cms -decrypt -in "$1" -inform DER -verify -noverify -out "$2"
}

# access config
function cf() {
  if [ $# -eq 0 ]; then
    nvim "+lua open_conf()"
  elif [[ "$1" == "zsh" ]]; then
    nvim ~/.dotfiles/zsh/.zshrc
  fi
}

# helper functions !! with colors !!
function is() {
  clear;
  hledger is --pretty -lS --drop 1 -p thismonth "$@" | ~/.finance/.src/scripts/colorize-report.py report
}

function iss() {
  clear;
  hledger is --pretty -lS --drop 1 -3 "$@" | ~/.finance/.src/scripts/colorize-report.py report
}

function bs() {
  clear;
  hledger bs --pretty -Vl --drop 1 "$@" | ~/.finance/.src/scripts/colorize-report.py report
}

function reg() {
  clear;
  hledger reg -p thismonth "$@" | ~/.finance/.src/scripts/colorize-report.py register
}

function regg() {
  clear;
  hledger reg "$@" | ~/.finance/.src/scripts/colorize-report.py register
}

function areg() {
  clear;
  hledger areg -p thismonth "$@" | ~/.finance/.src/scripts/colorize-report.py areg
}

function aregg() {
  clear;
  hledger areg "$@" | ~/.finance/.src/scripts/colorize-report.py areg
}

function bal() {
  clear;
  hledger bal --pretty "$@" | ~/.finance/.src/scripts/colorize-report.py register
}

function out() {
  clear;
  hledger bal --pretty cash fineco -p thismonth -D --transpose -T amt:"<0" --drop 1 "$@" | ~/.finance/.src/scripts/colorize-report.py cf
}

function dad() {
  clear;
  hledger -f ~/.finance/others/alfredo.journal bs --pretty -V --drop 1 "$@" | ~/.finance/.src/scripts/colorize-report.py report
}

function pvt() {
  clear;
  hledger is --pretty -lS --pivot payee -p thismonth "$@" | ~/.finance/.src/scripts/colorize-report.py pivot
}

# open git
function run_git() {
  if [[ $# -gt 0 ]] then
    git $@
  else
    nvim +Git +only
  fi
}

# aliases

# folder
alias dot='cd ~/.dotfiles'
alias dev='cd ~/Coding'
alias blog='cd ~/Coding/blog'
alias finance='cd ~/.finance'
alias ..='cd ..'
alias ...='cd ../..'

# colors on ls
alias ls='eza --all --git-ignore'
alias ll='eza --long --header --all --git --sort=modified --reverse'

# advent of code utilities
alias aoc='~/Coding/advent-of-code/utils/startup.sh'
alias aocd='cd ~/Coding/advent-of-code'

# rename programs
alias python='/usr/local/bin/python3.12'
alias pip='/usr/local/bin/pip3.12'
alias less='less -R'
alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'
alias u='brew update && brew upgrade && nvim +"lua require(\"lazy\").sync()"'
alias cat='bat --style="numbers,changes,header" --italic-text=always'
alias rg='rg -S'
alias n='nvim'
alias nn='nvim "+lua project_files()"'
alias ny='nvim "+lua open_live_grep()"'
alias ns='nvim "+lua open_git_status()"'
alias copy='pbcopy'
alias g='run_git'
alias tree='tree -I .git -a'

# ledger aliases
alias hl='hledger --pretty'
alias hlp='hledger print'
alias e='nvim +$ ~/.finance/periods/2024.journal'
alias ea='nvim +$ ~/.finance/others/alfredo.journal'
alias roi='clear; hledger roi --pretty --pnl "unrealized" -V --inv'
alias dadv='clear; hledger -f ~/.finance/others/alfredo.journal roi --pretty --pnl "unrealized" -V --inv VNGA'
alias pp='python3.12 ~/.finance/.src/scripts/fetch-mkt-prices.py'
alias p='cat ~/.finance/prices/current_prices.journal'

# kmonad
alias QQ='sudo killall kmonad'
alias qq='~/.dotfiles/kmonad/startup.sh 1'
alias qf='~/.dotfiles/kmonad/startup.sh 2'
