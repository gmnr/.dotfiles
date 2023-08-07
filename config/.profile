# customized PS1
# parse the git branch to show dirty status and the branch name
function parse_git_dirty {
      [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
  }

function parse_git_branch {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/<\1$(parse_git_dirty)> /"
  }

# show virtualenv in prompt if present
function virtualenv_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV"  ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=""
    fi
    [[ -n "$venv"  ]] && echo "<$venv> "
  }

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1

# show hostname if is different from mbp
function show_hostname() {
  if [[ `hostname -s` == "mbp" ]]; then
    host_value=""
  else
    host_value="@\h"
  fi
  [[ -n "$host_value"  ]] && echo "$host_value "
}

# show user if it's not guido
function show_user() {
  if [[ `whoami` == "guido" ]]; then
    user_value=""
  else
    user_value="\u"
  fi
  [[ -n "$user_value"  ]] && echo "$user_value"
}

function inbox_count() {
  inbox=$(task count +inbox pro:"" -COMPLETED -DELETED)
  if [[ $inbox -gt 0 ]]; then
    task_display=" Inbox: $inbox "
  else
    task_display=" "
  fi
  [[ -n "$task_display"  ]] && echo "$task_display"
}

# (old), dislays >> (virtual env) user@hostname:workingdir <git branch>
# EMBEDDED_PS1='$(virtualenv_info)\[\033[1;91m\]\u\[\033[00m\]@\[\033[1;94m\]\h\[\033[00m\]:\[\033[1;92m\]\w\[\033[1;96m\] $(parse_git_branch)\[\033[00m\]'

# (new prompt), dislays >> (virtual env) workingdir <git branch>
EMBEDDED_PS1='\[\033[1;95m\]$(inbox_count)$(virtualenv_info)\[\033[1;91m\]$(show_user)\[\033[1;94m\]$(show_hostname)\[\033[1;92m\]\w\[\033[1;96m\] $(parse_git_branch)'

# guide to colors
# 91 red
# 92 green
# 93 yellow
# 94 blue
# 95 magenta
# 96 cyan
# 97 grey

reset_readline_prompt_mode_strings () {
    # old config
    # bind "set vi-ins-mode-string \"${EMBEDDED_PS1@P}\1\e[00m\2$\""
    # bind "set vi-cmd-mode-string \"${EMBEDDED_PS1@P}\1\e[00m\2:\""

    # new config
    bind "set vi-ins-mode-string \"${EMBEDDED_PS1@P}\1\e[91m\2>\1\e[0m\2\""
    bind "set vi-cmd-mode-string \"${EMBEDDED_PS1@P}\1\e[93m\2:\1\e[0m\2\""
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
export VISUAL=nvim
export EDITOR="$VISUAL"
export PAGER=bat

# export the location of the dotfiles
export DOTFILES=~/.dotfiles

# add theme for bat
export BAT_THEME="base16-256"

# add bash-completion
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    . /usr/local/share/bash-completion/bash_completion
fi

# add completion for taskwarrior and others
if [ -f /usr/local/etc/bash-completion.d ]; then
    . /usr/local/etc/bash-completion.d
fi

# add git-completion
if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
fi

# make completion work for aliases
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g
complete -o nospace -F _task t
complete -o nospace -F _task ta
complete -o nospace -F _task c

## HLEDGER CONFIG ##
# add ledger_file
export LEDGER_FILE=$HOME/.finance/all.journal

# helper functions !! with colors !!
function is() {
  clear;
  hledger is --pretty -lS --drop 1 -p thismonth "$@" | ~/.finance/.src/colorize.py report
}

function iss() {
  clear;
  hledger is --pretty -lS --drop 1 -3 "$@" | ~/.finance/.src/colorize.py report
}


function bs() {
  clear;
  hledger bs --pretty -Vt --drop 1 -3 "$@" | ~/.finance/.src/colorize.py report
}

function cf() {
  clear;
  hledger cf --pretty -tS --drop 1 "$@" | ~/.finance/.src/colorize.py report
}

function reg() {
  clear;
  hledger reg -p thismonth "$@" | ~/.finance/.src/colorize.py register
}

function regg() {
  clear;
  hledger reg "$@" | ~/.finance/.src/colorize.py register
}


function areg() {
  clear;
  hledger areg -p thismonth "$@" | ~/.finance/.src/colorize.py areg
}

function aregg() {
  clear;
  hledger areg "$@" | ~/.finance/.src/colorize.py areg
}

function bal() {
  clear;
  hledger bal --pretty "$@" | ~/.finance/.src/colorize.py register
}

function cash() {
  clear;
  hledger print assets:cash | hledger -f- bal income: expenses: --pretty --drop 1 -t --invert | ~/.finance/.src/colorize.py report
}

function dad() {
  clear;
  hledger -f ~/.finance/others/alfredo.journal bs --pretty -V --drop 1 "$@" | ~/.finance/.src/colorize.py report
}

function fede() {
  clear;
  hledger -f ~/.finance/others/fede.journal bs --pretty -V --drop 1 "$@" | ~/.finance/.src/colorize.py report
}

