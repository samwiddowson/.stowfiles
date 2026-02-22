#!/bin/zsh

menu_items='󰌾  Lock\n󰐥  Shut Down\n󰗽  Log Out\n󰜉  Reboot'

confirm() {
    local action="$1"
    local result=$(echo -e "Yes, $action\n Cancel" | wofi --dmenu \
        --prompt "Confirm" -k /dev/null \
        -c "$HOME/.config/wofi/power-menu.conf")

    [[ "$result" == *"Yes"* ]] && return 0 || return 1
}


choice=$(echo -e "$menu_items" | wofi --dmenu \
    --prompt "Power" -k /dev/null \
    -c "$HOME/.config/wofi/power-menu.conf")

case "$choice" in
    *"Shut Down"*)
        confirm "shut down" && systemctl poweroff
        ;;
    *"Reboot"*)
        confirm "reboot" && systemctl reboot
        ;;
    *"Lock"*)
        hyprlock
        ;;
    *"Log Out"*)
        confirm "log out" && hyprshutdown
        ;;
esac
