#!/bin/sh
# Jump to the next empty workspace (1-10 range)
# Searches sequentially from current+1, wrapping around if needed

# Ensure full PATH is available when called from Hyprland exec
export PATH="/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH"

# Get current workspace ID
current=$(hyprctl activeworkspace -j | jq -r '.id') || exit 1

# Get list of occupied workspace IDs
occupied=$(hyprctl workspaces -j | jq -r '.[].id') || exit 1

# Search for first empty workspace starting from current+1
for offset in $(seq 1 10); do
    # Calculate next workspace ID with wraparound (1-10 range)
    next=$(( (current - 1 + offset) % 10 + 1 ))
    
    # Check if this workspace is empty
    if ! echo "$occupied" | grep -q "^${next}$"; then
        # Found empty workspace, switch to it
        hyprctl dispatch workspace "$next"
        exit 0
    fi
done

# All workspaces 1-10 are occupied, do nothing
exit 0
