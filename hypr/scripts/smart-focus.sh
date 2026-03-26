#!/usr/bin/env bash
# Smart focus: try tiling movefocus first, fall back to workspace/monitor if at edge.
# Usage: smart-focus.sh <l|r|u|d>

dir="$1"
script_dir="$(dirname "$0")"

# Capture currently focused window
before=$(hyprctl activewindow -j | jq -r '.address')

# Attempt tiling focus
hyprctl dispatch movefocus "$dir"
sleep 0.05

# Check if focus changed
after=$(hyprctl activewindow -j | jq -r '.address')

# If same window is still focused, we're at the edge — fall back
if [ "$before" = "$after" ]; then
  case "$dir" in
    l) hyprctl dispatch focusmonitor l ;;
    r) hyprctl dispatch focusmonitor r ;;
    d) exec "$script_dir/workspace-cycle.sh" +1 ;;
    u) exec "$script_dir/workspace-cycle.sh" -1 ;;
  esac
fi
