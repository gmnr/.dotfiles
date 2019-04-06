# customized PS1
##
# parse the git branch to show dirty status and the branch name
function parse_git_dirty {
      [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
  }

function parse_git_branch {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
  }

export PS1='\[\033[1;93m\][\A] \[\033[1;91m\]\u \[\033[1;97m\]at \[\033[1;94m\]\h \[\033[1;92m\]\w\[\033[1;96m\] $(parse_git_branch) \[\033[00m\]\$ '


# better colors
export CLICOLOR=1;
export CLICOLOR_FORCE=1;
export LSCOLORS=Exfxcxdxbxegedabagacad;
export GREP_OPTIONS='--color=always'

# dsable ctrl-s (terminal freeze)
stty -ixon

# read aliases
if [ -f ~/.alias ]; then
    . ~/.alias
fi

# make vim default editor
export VISUAL=vim
export EDITOR="$VISUAL"
