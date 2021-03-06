# customized PS1
##
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
        venv=''
    fi
    [[ -n "$venv"  ]] && echo "<$venv> "
  }

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1

#export PS1='$(virtualenv_info)\[\033[1;91m\]\u\[\033[00m\]@\[\033[1;94m\]\h\[\033[00m\]:\[\033[1;92m\]\w\[\033[1;96m\] $(parse_git_branch)\[\033[00m\]\$ '
EMBEDDED_PS1='$(virtualenv_info)\[\033[1;91m\]\u\[\033[00m\]@\[\033[1;94m\]\h\[\033[00m\]:\[\033[1;92m\]\w\[\033[1;96m\] $(parse_git_branch)\[\033[00m\]'
reset_readline_prompt_mode_strings () {
    bind "set vi-ins-mode-string \"${EMBEDDED_PS1@P}\1\e[0m\2$\""
    bind "set vi-cmd-mode-string \"${EMBEDDED_PS1@P}\1\e[0m\2:\""
}
PROMPT_COMMAND=reset_readline_prompt_mode_strings
PS1=' '
#PS2=' ... '


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
export VISUAL=vim
export EDITOR="$VISUAL"

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

# add options for fzf
export FZF_DEFAULT_OPTS='--height 30% --layout=reverse --no-bold'
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
