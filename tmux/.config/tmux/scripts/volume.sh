#!/usr/bin/env bash
# Print default output volume as "N%" for tmux-nova (Linux: pactl, wpctl, or amixer).

linux_volume() {
  local line v

  if command -v pactl >/dev/null 2>&1; then
    line=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | head -n1) || true
    if [[ -n "$line" ]]; then
      v=$(echo "$line" | grep -oE '[0-9]+%' | head -1 | tr -d '%')
      if [[ -n "$v" ]]; then
        printf '%s%' "$v"
        return 0
      fi
    fi
  fi
}

if [[ "$(uname -s)" = Linux ]]; then
  linux_volume
fi
exit 0
