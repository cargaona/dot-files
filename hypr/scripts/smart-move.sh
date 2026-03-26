#!/usr/bin/env bash
# Smart move: try tiling movewindow first, fall back to workspace/monitor move if at edge.
# Usage: smart-move.sh <l|r|u|d>

dir="$1"
script_dir="$(dirname "$0")"

# Capture current position
before=$(hyprctl activewindow -j | jq -r '[.at[0], .at[1], .size[0], .size[1]] | @csv')

# Attempt tiling move
hyprctl dispatch movewindow "$dir"
sleep 0.05

# Capture new position
after=$(hyprctl activewindow -j | jq -r '[.at[0], .at[1], .size[0], .size[1]] | @csv')

# If nothing changed, the window is at the edge — fall back
if [ "$before" = "$after" ]; then
  case "$dir" in
    l) exec "$script_dir/move-to-monitor.sh" l ;;
    r) exec "$script_dir/move-to-monitor.sh" r ;;
    d) exec "$script_dir/workspace-cycle.sh" +1 --move ;;
    u) exec "$script_dir/workspace-cycle.sh" -1 --move ;;
  esac
fi
