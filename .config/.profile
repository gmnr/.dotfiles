# customized PS1
# parse the git branch to show dirty status and the branch name
function parse_git_dirty {
      [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
  }

function parse_git_branch {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/<\1$(parse_git_dirty)> /"
  }

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

RED="\033[1;91m"
GREEN="\033[1;92m"
YELLOW="\033[1;93m"
BLUE="\033[1;94m"
MAGENTA="\033[1;95m"
CYAN="\033[1;96m"
RESET="\033[00m"

# prompt
EMBEDDED_PS1="$(virtualenv_info)${RED}\u${RESET}@${BLUE}\h${RESET}:${GREEN}\w ${CYAN}$(parse_git_branch)"

reset_readline_prompt_mode_strings () {
    bind "set vi-ins-mode-string \"${EMBEDDED_PS1@P}\1\e[0m\2$\""
    bind "set vi-cmd-mode-string \"${EMBEDDED_PS1@P}\1\e[0m\2:\""
}

PROMPT_COMMAND=reset_readline_prompt_mode_strings
PS1=" "

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

# export the location of the dotfiles
export DOTFILES=~/.dotfiles

# add theme for bat
export BAT_THEME="TwoDark"

# add bash-completion
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    . /usr/local/share/bash-completion/bash_completion
fi

# add git-completion
if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
fi

# add ledger_file
export LEDGER_FILE=$HOME/.finance/all.journal

# taskwarrior config
# generic aliases
alias t='task'
alias in='task add folder:inbox'

# reports
alias ti='task inbox'  # show inbox report
alias tn='task nx'  # show next report
alias tt='task waiting'  # show waiting report
alias tl='task later'  # show later report

# custom commands
alias tm='task mod'  # modify number task
alias tn='task ann'  # annotate the task
alias tp='process'  # choose the folder for the task (and add eventual metadata)
alias ta='assign'  # assign owner for the task
alias tw='task_wait'  # wait task for a later date

# set task to wait
task_wait () {
    item=$1
    shift
    task mod $item wait:$*
}

# assign task to folder
assign () {
    item=$1
    shift
    task mod $item owner:$*
}

# move tasks to correct folder
process () {
    item=$1
    shift
    task mod $item folder:$*
}
