#!/bin/zsh

# Get the currently playing player name
player=$(playerctl --list-all | head -1)

case "$player" in
    firefox*)
        hyprctl dispatch focuswindow "class:firefox"
        ;;
    spotify*)
        hyprctl dispatch focuswindow "class:Spotify"
        ;;
    chromium*)
        hyprctl dispatch focuswindow "class:chromium"
        ;;
    vlc*)
        hyprctl dispatch focuswindow "class:vlc"
        ;;
    *)
        # Fallback: just toggle play/pause
        playerctl play-pause
        ;;
esac
