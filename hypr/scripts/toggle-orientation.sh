#!/bin/sh
# Toggle master layout orientation between top (vertical stack) and left (side-by-side)
# for the CURRENT workspace. Uses layoutmsg dispatchers which operate per-workspace.
# State is tracked in /tmp since Hyprland doesn't expose per-workspace orientation.

# Ensure full PATH is available when called from Hyprland exec
export PATH="/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH"

WS_ID=$(hyprctl activeworkspace -j | jq -r '.id')
STATE_FILE="/tmp/hypr-orientation-ws-$WS_ID"

# Default: workspaces 6-10 (DP-1 vertical monitor) start as top, others as left
if [ -f "$STATE_FILE" ]; then
    CURRENT=$(cat "$STATE_FILE")
elif [ "$WS_ID" -ge 6 ] && [ "$WS_ID" -le 10 ]; then
    CURRENT="top"
else
    CURRENT="left"
fi

if [ "$CURRENT" = "top" ]; then
    hyprctl dispatch layoutmsg orientationleft
    echo "left" > "$STATE_FILE"
else
    hyprctl dispatch layoutmsg orientationtop
    echo "top" > "$STATE_FILE"
fi
