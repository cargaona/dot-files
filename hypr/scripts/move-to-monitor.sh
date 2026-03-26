#!/usr/bin/env bash
# Move the active window to the other monitor's active workspace and follow focus.
# Usage: move-to-monitor.sh <l|r>

direction="$1"

# Find the target monitor's active workspace
# focusmonitor direction maps: l=left, r=right
target_ws=$(hyprctl monitors -j | jq -r \
  --arg dir "$direction" \
  '[.[] | select(.focused == false)][0].activeWorkspace.id')

[ -z "$target_ws" ] && exit 1

hyprctl dispatch movetoworkspace "$target_ws"
