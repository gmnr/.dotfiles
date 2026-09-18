# improve performance
autoload -U zmv
setopt extended_glob
export PATH=/opt/homebrew/bin:$PATH

# set autocompletion
if type brew &>/dev/null; then
    if [[ -d "/opt/homebrew/share/zsh/site-functions" ]]; then
        FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
    elif [[ -d "/usr/local/share/zsh/site-functions" ]]; then
        FPATH="/usr/local/share/zsh/site-functions:${FPATH}"
    else
        FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    fi
fi

if [[ -z "$TMUX" && -n "$KITTY_WINDOW_ID" && -z "$TMUX_HANDLED" ]]; then
    export TMUX_HANDLED=1
    if command -v tmux >/dev/null 2>&1; then
        tmux attach-session -t main 2>/dev/null || tmux new-session -s main
        exit
    fi
fi

autoload -Uz compinit
if [[ -n ~/.zcompdump(N.mh+24) ]]; then
    compinit
else
    compinit -C
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# enable vi mode
source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# disable execute prompt
bindkey -e -r '^[x'
bindkey -a -r ':'

# show `*` if git status is dirty
function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}

function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ <\1$(parse_git_dirty)> /"
}

setopt PROMPT_SUBST
PROMPT='%B%F{green} %~%f %F{cyan}$(parse_git_branch)%f%F{red}>%f%b '

# don't collapse space after autocomplete
ZLE_SPACE_SUFFIX_CHARS=$'&|'

# load external config files
source $HOME/.dotfiles/zsh/aliases.sh
source $HOME/.dotfiles/zsh/shell-functions.sh
source $HOME/.dotfiles/hledger/hledger-shell.sh
