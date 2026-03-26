#!/usr/bin/env bash
# Cycle workspaces on the current monitor only, with wrap-around.
# Usage: workspace-cycle.sh <+1|-1> [--move] [--silent]
#   +1 = next workspace, -1 = previous workspace
#   --move = move active window to target workspace (and follow focus)
#   --silent = with --move, don't follow focus

direction="$1"
move=false
silent=false

shift
for arg in "$@"; do
  case "$arg" in
    --move) move=true ;;
    --silent) silent=true ;;
  esac
done

# Get current workspace ID and monitor name
eval "$(hyprctl activeworkspace -j | jq -r '@sh "current=\(.id) monitor=\(.monitor)"')"

# Determine workspace range based on monitor
case "$monitor" in
  HDMI-A-1) min=1; max=5 ;;
  DP-1)     min=6; max=10 ;;
  *)        exit 1 ;;
esac

# Calculate target with wrap-around
range=$((max - min + 1))
target=$(( min + (current - min + direction + range) % range ))

# Dispatch
if $move && $silent; then
  hyprctl dispatch movetoworkspacesilent "$target"
elif $move; then
  hyprctl dispatch movetoworkspace "$target"
else
  hyprctl dispatch workspace "$target"
fi
