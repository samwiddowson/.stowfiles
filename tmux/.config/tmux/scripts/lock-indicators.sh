#!/usr/bin/env bash
# Caps / Num Lock indicators for tmux-nova (Linux sysfs; Wayland/X11/TTY).
# No output if LED sysfs nodes are unavailable (VMs, some drivers, non-Linux).

set -euo pipefail

readonly ACTIVE_FG='#f3bc70'
readonly INACTIVE_FG='#76859b'
readonly CAPS_ICON='󰫮'
readonly NUM_ICON='󰬹'

# Returns 0 and echoes 0 or 1 if a readable LED brightness file exists; else returns 1.
read_lock_brightness() {
  local path val
  shopt -s nullglob
  for path in /sys/class/leds/input*::"${1}"/brightness; do
    if [[ -r "$path" ]]; then
      val=$(cat "$path" 2>/dev/null || echo 0)
      if [[ "${val:-0}" -gt 0 ]]; then
        printf '1'
      else
        printf '0'
      fi
      return 0
    fi
  done
  return 1
}

print_caps() {
  local v
  if ! v=$(read_lock_brightness capslock); then
    return 0
  fi
  if [[ "$v" = 1 ]]; then
    printf '#[fg=%s]%s' "$ACTIVE_FG" "$CAPS_ICON"
  else
    printf '#[fg=%s]%s' "$INACTIVE_FG" "$CAPS_ICON"
  fi
}

print_num() {
  local v
  if ! v=$(read_lock_brightness numlock); then
    return 0
  fi
  if [[ "$v" = 1 ]]; then
    printf '#[fg=%s]%s' "$ACTIVE_FG" "$NUM_ICON"
  else
    printf '#[fg=%s]%s' "$INACTIVE_FG" "$NUM_ICON"
  fi
}

case "${1:-}" in
  caps) print_caps ;;
  num) print_num ;;
  *) ;;
esac
