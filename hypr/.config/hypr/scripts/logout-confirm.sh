#!/bin/zsh

confirm() {
    local action="$1"
    local result=$(echo -e "Yes, $action\n Cancel" | wofi --dmenu \
        --prompt "Confirm" -k /dev/null \
        -c "$HOME/.config/wofi/power-menu.conf")

    [[ "$result" == *"Yes"* ]] && return 0 || return 1
}

confirm "log out" && ~/.config/hypr/scripts/logout.sh
