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
source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# show `*` if git status is dirty
function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}

# show `!` if on remote branch there are further commits
function parse_git_upstream() {
    [[ $(git branch -vr 2> /dev/null | tail -n1 | cut -d ' ' -f 4) != $(git rev-parse --short HEAD 2> /dev/null) ]] && echo " !"
}

function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ <\1$(parse_git_dirty)$(parse_git_upstream)> /"
}

setopt PROMPT_SUBST
PROMPT='%B%F{green} %~%f %F{cyan}$(parse_git_branch)%f%F{red}>%f%b '

# load external config files
source $HOME/.dotfiles/zsh/aliases.sh
source $HOME/.dotfiles/zsh/shell-functions.sh
source $HOME/.dotfiles/hledger/hledger-shell.sh
