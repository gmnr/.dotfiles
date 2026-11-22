#!/bin/zsh
# hledger helper functions
function _hl() {
    clear
    hledger "${@:2}" | $DOTFILES/hledger/scripts/colorize-report.py "$1"
}

function is()    { _hl report   is -p thismonth "$@" }
function iss()   { _hl report   is -3 "$@" }
function reg()   { _hl register reg -p thismonth -w $COLUMNS "$@" }
function regg()  { _hl register reg -w $COLUMNS "$@" }
function areg()  { _hl areg     areg -p thismonth -w $COLUMNS "$@" }
function aregg() { _hl areg     areg -w $COLUMNS "$@" }
function bal()   { _hl register bal "$@" }
function out()   { _hl cf       bal current not:liabilities -p thismonth -D --transpose -T amt:"<0" --drop 1 "$@" }
function pvt()   { _hl pivot    is --drop 0 --pivot payee -p thismonth "$@" }

function bs() {
    # extract the period to which rebase the calculations
    local period=$(echo $@ | rg -e "-p \d{4}(\/\d+)?|lastmonth" -o | cut -d " " -f 2)

    # execute the calculation on that interval and run the report
    python3 $DOTFILES/hledger/scripts/capital-gain-taxes.py $period 2> /dev/null
    _hl report bs "$@"
}

# hledger aliases
alias hl='hledger'
alias hlp='hledger print'
alias e='nvim +$ ~/.finance/periods/2026.journal'
alias pp='python3 $DOTFILES/hledger/scripts/fetch-mkt-prices.py && python3 $DOTFILES/hledger/scripts/capital-gain-taxes.py'
alias prices='cat ~/.finance/prices/current_prices.journal'

# hledger shorthand for zsh
export TRAVELS=tag:travels
export MINORE=amt:"<0"
export MAGGIORE=amt:">0"
