# aliases
alias ll='ls -alh'
alias ls='ls -lt'
alias cu='chmod u+x'
alias pproj='cd ~/Documents/Coding'
alias home='ssh home-server'
alias python='python3'


# parse the git branch to show dirty status and the branch name
function parse_git_dirty {
      [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
  }

function parse_git_branch {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
  }

export PS1='\[\033[93m\][\A] \[\033[1;91m\]\u \[\033[1;92m\]\w\[\033[1;94m\] $(parse_git_branch) \[\033[00m\]\$ '


# better colors
export CLICOLOR=1;
export LSCOLORS=Exfxcxdxbxegedabagacad;
export GREP_OPTIONS='--color=auto'

# dsable ctrl-s (terminal freeze)
stty -ixon
