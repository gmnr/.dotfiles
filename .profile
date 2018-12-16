# aliases
alias la='ls -alt'
alias lt='ls -alh'
alias l='ls -CF'
alias ll='ls -lt'
alias cu='chmod u+x'
alias home='ssh home-server'
alias berry='ssh pi'
alias pprj='cd ~/Desktop/Projects'


# get the branch in prompt
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[93m\][\A] \[\033[1;91m\]\u \[\033[1;92m\]\w\[\033[1;94m\]$(__git_ps1)\n\[\033[00m\]\$ '


# better colors
export CLICOLOR=1;
export LSCOLORS=Exfxcxdxbxegedabagacad;
export GREP_OPTIONS='--color=auto'
