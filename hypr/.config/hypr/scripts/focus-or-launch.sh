#!/bin/zsh

app_name="$1"
launch_cmd="$2"

# Check if requested app is running
if hyprctl clients -j | jq -e '.[] | select(.class == "'$app_name'")' > /dev/null 2>&1; then
    # Focus it
    hyprctl dispatch focuswindow "class:$app_name"
    notify-send "Existing Terminal" "Switched to existing app $app_name on workspace $(hyprctl activeworkspace -j | jq -r '.id')."
else
    # Launch new kitty with tmux
    # notify-send "DEBUG" "$launch_cmd"
    eval $launch_cmd
fi
