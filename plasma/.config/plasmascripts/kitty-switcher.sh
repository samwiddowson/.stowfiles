#!/usr/bin/env bash

if pgrep -x "kitty" > /dev/null; then
    SCRIPT_PATH=$(mktemp)
    SCRIPT_NAME="switch_kitty_$$"

    cat << 'EOF' > "$SCRIPT_PATH"
    var clients = workspace.windowList();
    for (var i = 0; i < clients.length; i++) {
        if (clients[i].resourceClass === 'kitty') {
            workspace.activeWindow = clients[i];
            break;
        }
    }
EOF

    # Load script into KWin
    SCRIPT_ID=$(qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.loadScript "$SCRIPT_PATH" "$SCRIPT_NAME")

    if [ "$SCRIPT_ID" -ge 0 ]; then
        SCRIPT_DBUS_PATH="/Scripting/Script${SCRIPT_ID}"

        # Run and clean up the loaded script object
        qdbus org.kde.KWin "$SCRIPT_DBUS_PATH" org.kde.kwin.Script.run
        qdbus org.kde.KWin /Scripting org.kde.kwin.Scripting.unloadScript "$SCRIPT_NAME" 2>/dev/null
    fi

    rm "$SCRIPT_PATH"
else
    kitty --start-as=fullscreen sh -lc 'tmux attach || tmux new' &
fi
