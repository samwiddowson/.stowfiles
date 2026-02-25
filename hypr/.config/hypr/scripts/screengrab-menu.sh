#!/bin/zsh

menu_items='󰗆  Area\n  Active Window\n󰍹  Entire Screen'

result=$(echo -e "$menu_items" | wofi --dmenu \
    --prompt "Screenshot Target" -k /dev/null \
    -c "$HOME/.config/wofi/screen-grab.conf")

case "$result" in
    *"Area"*)
        target="area"
        ;;
    *"Active Window"*)
        target="active"
        ;;
    *"Entire Screen"*)
        target="screen"
        ;;
esac

echo target is $target

grimblast --notify --filetype png --wait 0.2 copysave $target
