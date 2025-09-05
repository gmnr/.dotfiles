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
  openssl cms -decrypt -in "$1" -inform DER -verify -noverify -out "$2"
}

# helper functions !! with colors !!
function is() {
  clear;
  hledger is -p thismonth "$@" | ~/.finance/.src/scripts/colorize-report.py report
}

function iss() {
  clear;
  hledger is -3 "$@" | ~/.finance/.src/scripts/colorize-report.py report
}

function bs() {
  clear;
  hledger bs "$@" | ~/.finance/.src/scripts/colorize-report.py report
}

function reg() {
  clear;
  hledger reg -p thismonth -w $COLUMNS "$@" | ~/.finance/.src/scripts/colorize-report.py register
}

function regg() {
  clear;
  hledger reg -w $COLUMNS "$@" | ~/.finance/.src/scripts/colorize-report.py register
}

function areg() {
  clear;
  hledger areg -p thismonth -w $COLUMNS "$@" | ~/.finance/.src/scripts/colorize-report.py areg
}

function aregg() {
  clear;
  hledger areg -w $COLUMNS "$@" | ~/.finance/.src/scripts/colorize-report.py areg
}

function bal() {
  clear;
  hledger bal "$@" | ~/.finance/.src/scripts/colorize-report.py register
}

function out() {
  clear;
  hledger bal cash fineco -p thismonth -D --transpose -T amt:"<0" --drop 1 "$@" | ~/.finance/.src/scripts/colorize-report.py cf
}

function pvt() {
  clear;
  hledger is --pivot payee -p thismonth "$@" | ~/.finance/.src/scripts/colorize-report.py pivot
}

# open git
function run_git() {
  if [[ $# -gt 0 ]] then
    git $@
  else
    nvim +"vert Git"
  fi
}

# open nvim
function run_nvim() {
  if [[ $# -gt 0 ]] then
    nvim $@
  else
    if [[ $(git status 2> /dev/null) == "" ]] then
      nvim
    else
      if [[ $(parse_git_dirty) == '*' ]] then
        nvim +"lua require(\"snacks\").picker.git_status()"
      else
        nvim +"lua require(\"snacks\").picker.files({ cwd = Snacks.git.get_root() })"
      fi
    fi
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
alias n='run_nvim'
alias copy='pbcopy'
alias g='run_git'
alias tree='tree -I .git -a'

# ledger aliases
alias hl='hledger'
alias hlp='hledger print'
alias e='nvim +$ ~/.finance/periods/2025.journal'
alias roi='clear; hledger roi --pnl "unrealized" -V --inv'
alias pp='python3 ~/.finance/.src/scripts/fetch-mkt-prices.py && python3 ~/.finance/.src/scripts/capital-gain-taxes.py'
alias prices='cat ~/.finance/prices/current_prices.journal'

# kmonad
alias qq='sudo killall kmonad && ~/.dotfiles/kmonad/startup.sh 1'
alias ww='sudo killall kmonad && ~/.dotfiles/kmonad/startup.sh 2'
alias QQ='sudo killall kmonad'
