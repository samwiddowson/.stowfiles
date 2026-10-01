#!/bin/zsh

# Ensure script stops on errors
set -e

local direction="${1:l}" # Convert to lowercase
local desktop_num="$2"

# Validate input parameters
if [[ -z "$direction" || -z "$desktop_num" ]]; then
    print -u2 "Usage: $0 [above|below] [1-5]"
    exit 1
fi

local screen_shortcut
case "$direction" in
    above|top)    screen_shortcut="Switch to Screen 0" ;;
    below|bottom) screen_shortcut="Switch to Screen 1" ;;
    *) 
        print -u2 "Error: Invalid direction '$direction'. Use 'above' or 'below'."
        exit 1
        ;;
esac

# 1. Switch focus to the target screen
qdbus org.kde.kglobalaccel /component/kwin org.kde.kglobalaccel.Component.invokeShortcut "$screen_shortcut"

# 2. Switch desktop on the newly focused screen
qdbus org.kde.kglobalaccel /component/kwin org.kde.kglobalaccel.Component.invokeShortcut "Switch to Desktop $desktop_num"
