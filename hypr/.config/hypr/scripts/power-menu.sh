#!/bin/zsh

menu_items='󰌾  Lock\n󰗽  Log Out\n󰐥  Shut Down\n󰜉  Reboot'

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
        confirm "shut down" && hyprshutdown -p "systemctl poweroff"
        ;;
    *"Reboot"*)
        confirm "reboot" && hyprshutdown -p "systemctl reboot"
        ;;
    *"Lock"*)
        hyprlock
        ;;
    *"Log Out"*)
        confirm "log out" && ~/.config/hypr/scripts/logout.sh
        ;;
esac
