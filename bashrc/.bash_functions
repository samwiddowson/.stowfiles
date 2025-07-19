#!/usr/bin/env bash

function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

function devenv(){
    SESSION_NAME="devenv"
    tmux new-session -d -s "$SESSION_NAME" -n neovim 'nvim .'
    tmux new-window -t "$SESSION_NAME:" -n shell
    tmux display -t "$SESSION_NAME:editor"

    tmux attach-session -t "$SESSION_NAME"
}

function fuck() {
  sudo $(fc -ln -1)
}

