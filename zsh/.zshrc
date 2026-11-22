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
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
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

# history settings
HISTSIZE=50000
SAVEHIST=50000
setopt share_history hist_ignore_all_dups hist_ignore_space

# show ` <branch> ` in git repos, with `*` if the work tree is dirty
# (porcelain output doesn't depend on git's language or wording)
function parse_git_branch() {
  local ref
  ref=$(git symbolic-ref --short -q HEAD 2> /dev/null || git rev-parse --short HEAD 2> /dev/null) || return
  [[ -n $(git status --porcelain 2> /dev/null) ]] && ref+="*"
  echo "<$ref> "
}


setopt PROMPT_SUBST
PROMPT='%B%F{green} %~%f %F{cyan}$(parse_git_branch)%f%F{red}>%f%b '

# don't collapse space after autocomplete
ZLE_SPACE_SUFFIX_CHARS=$'&|'

# load external config files
source $DOTFILES/zsh/aliases.sh
source $DOTFILES/zsh/shell-functions.sh
source $DOTFILES/hledger/hledger-shell.sh
