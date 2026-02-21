#!/bin/zsh

menu_items="󰌾  Lock\n󰐥  Shut Down\n󰜉  Reboot\n󰗽  Log Out"

choice=$(echo -e "$menu_items" | wofi --dmenu \
    --prompt "Power" \
    -c "$HOME/.config/wofi/power-menu.conf")

case "$choice" in
    *"Shut Down"*)
        systemctl poweroff
        ;;
    *"Reboot"*)
        systemctl reboot
        ;;
    *"Lock"*)
        hyprlock
        ;;
    *"Log Out"*)
        hyprshutdown
        ;;
esac
