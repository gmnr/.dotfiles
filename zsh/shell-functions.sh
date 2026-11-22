#!/bin/zsh
# functions
 # update everything: Homebrew packages, nvim plugins, Mason tools
function upd() {
    brew update && brew upgrade || return
    nvim --headless "+Lazy! sync" +qa
    nvim --headless -c 'lua require("modules.mason_upgrade").run({ wait = true })' -c qa
}

# open p7m
function decrypt() {
    openssl cms -decrypt -in "$1" -inform DER -verify -noverify -out "${1%.p7m*}"
}

# create dir and move into it
function mkcd () {
    \mkdir -p "$1"
    cd "$1"
}

# create temp dir
function tempe () {
    cd "$(mktemp -d -p /tmp)"
    chmod -R 0700 .
    if [[ $# -eq 1 ]]; then
        \mkdir -p "$1"
        cd "$1"
        chmod -R 0700 .
    fi
}

# open git
function run_git() {
    if [[ $# -gt 0 ]] then
        git "$@"
    else
        nvim +"Neogit"
    fi
}
compdef run_git=git # complete like git
