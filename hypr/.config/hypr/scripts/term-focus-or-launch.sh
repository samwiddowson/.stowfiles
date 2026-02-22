#!/bin/zsh

# Check if kitty window exists
if hyprctl clients -j | jq -e '.[] | select(.class == "kitty")' > /dev/null 2>&1; then
    # Focus it
    hyprctl dispatch focuswindow "class:kitty"
    notify-send "Existing Terminal" "Switched to existing terminal client on workspace $(hyprctl activeworkspace -j | jq -r '.id')."
else
    # Launch new kitty with tmux
    kitty tmux new-session -A
fi
