#!/bin/zsh

# Get current default sink
current=$(pactl get-default-sink)

# Build list: current device first, then others
sinks=""
current_line=""

while IFS= read -r line; do
    name=${${line##*Name: }%%$'\t'*}
    desc=${line##*Description: }
   
    if [[ "$name" == "$current" ]]; then
        current_line="► $desc"
    else
        [[ -n "$sinks" ]] && sinks+="\n"
        sinks+="  $desc"
    fi
done < <(pactl list sinks | grep -E "Name:|Description:" | paste - -)

# Current first, then others (no blank lines)
if [[ -n "$sinks" ]]; then
    all_sinks="${current_line}\n${sinks}"
else
    all_sinks="${current_line}"
fi

# Show picker with custom config
choice=$(print -P "$all_sinks" | wofi --dmenu \
    --prompt "Output" \
    -c "$HOME/.config/wofi/audio-switch.conf")

# Exit if cancelled
[[ -z "$choice" ]] && exit 0

# Remove leading marker/spaces and get description
desc="${choice#► }"
desc="${desc#  }"

# Find sink name from description
sink=$(pactl list sinks | grep -B1 "Description: ${desc}$" | grep "Name:" | sed 's/.*Name: //')

# Set as default and move existing streams
if [[ -n "$sink" ]]; then
    pactl set-default-sink "$sink"
    # Move all current audio streams to new sink
    pactl list sink-inputs short | awk '{print $1}' | while read stream; do
        pactl move-sink-input "$stream" "$sink" 2>/dev/null
    done
    notify-send "Audio Output" "Switched to: $desc" -t 2000
fi
