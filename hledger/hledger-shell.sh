# hledger helper functions
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

# hledger aliases
alias hl='hledger'
alias hlp='hledger print'
alias e='nvim +$ ~/.finance/periods/2026.journal'
alias pp='python3 ~/.dotfiles/hledger/scripts/fetch-mkt-prices.py && python3 ~/.dotfiles/hledger/scripts/capital-gain-taxes.py'
alias prices='cat ~/.finance/prices/current_prices.journal'
