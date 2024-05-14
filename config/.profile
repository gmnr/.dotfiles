# customized PS1
# parse the git branch to show dirty status and the branch name
function parse_git_dirty {
      [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
  }

function parse_git_branch {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/<\1$(parse_git_dirty)> /"
  }

EMBEDDED_PS1=' \[\033[1;92m\]\w\[\033[1;96m\] $(parse_git_branch)\[\033[1;91m\]'

reset_readline_prompt_mode_strings () {
    bind "set vi-ins-mode-string \"${EMBEDDED_PS1@P}\1\e[91m\2>\1\e[0m\2\""
    bind "set vi-cmd-mode-string \"${EMBEDDED_PS1@P}\1\e[91m\2>\1\e[93m\2\""
}

PROMPT_COMMAND=reset_readline_prompt_mode_strings
PS1=' '

# custom vim function
function run_git() {
  if [[ $# -gt 0 ]] then
    git $@
  else
    nvim +Git +only
  fi
}

# better colors
export CLICOLOR=1;
export CLICOLOR_FORCE=1;

# add compatibility for GREP_OPTION in macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    export GREP_OPTIONS='--color=always'
else
    export LESS="-SRXF"
fi

# dsable ctrl-s (terminal freeze)
stty -ixon

# read aliases
if [ -f ~/.alias ]; then
    . ~/.alias
fi

# make vim default editor
export EDITOR=nvim
export VISUAL="$EDITOR"
export PAGER=bat

# export the location of the dotfiles
export DOTFILES=~/.dotfiles

# add bash-completion
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    . /usr/local/share/bash-completion/bash_completion
fi

# add git-completion
if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
fi

# make completion work for aliases
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g

## HLEDGER CONFIG ##
# add ledger_file
export LEDGER_FILE=$HOME/.finance/all.journal

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

function pivot() {
  clear;
  hledger is --pretty -lS --pivot payee -p thismonth "$@" | ~/.finance/.src/scripts/colorize-report.py pivot
}

