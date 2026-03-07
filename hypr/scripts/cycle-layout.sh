#!/usr/bin/env bash
# Cycle through available Hyprland layouts with auto-detection
# Supports: master, dwindle, scrolling (built-in), and scroller (if plugin is installed)

# Get current layout (handle case when Hyprland isn't running)
current_layout=$(hyprctl getoption general:layout -j 2>/dev/null | jq -r '.str' 2>/dev/null || echo "master")

# Check if scroller plugin is available
scroller_available=false
if hyprctl plugins list 2>/dev/null | grep -q "hyprscroller\|scroller"; then
    scroller_available=true
fi

# Define available layouts based on what's installed
if [[ "$scroller_available" == true ]]; then
    layouts=("master" "dwindle" "scrolling" "scroller")
else
    layouts=("master" "dwindle" "scrolling")
fi

# Find current layout index
current_index=-1
for i in "${!layouts[@]}"; do
    if [[ "${layouts[$i]}" == "$current_layout" ]]; then
        current_index=$i
        break
    fi
done

# If current layout isn't in our list, default to master
if [[ $current_index -eq -1 ]]; then
    current_index=0
fi

# Calculate next layout index (cycle back to 0 after last)
next_index=$(( (current_index + 1) % ${#layouts[@]} ))
next_layout="${layouts[$next_index]}"

# Switch to next layout
hyprctl keyword general:layout "$next_layout"

# Notify user (optional - remove if you don't want notifications)
if command -v notify-send >/dev/null 2>&1; then
    notify-send "Layout switched" "Now using: $next_layout" -t 2000 -u low
fi

echo "Layout switched from ${current_layout:-unknown} to $next_layout"