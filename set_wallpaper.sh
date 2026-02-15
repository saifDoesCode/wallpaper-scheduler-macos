#!/bin/bash

# Script to set wallpaper on all displays
# Usage: ./set_wallpaper.sh <path_to_image>

if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_wallpaper>"
    exit 1
fi

WALLPAPER_PATH="$1"

# Check if file exists
if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "Error: Wallpaper file not found: $WALLPAPER_PATH"
    exit 1
fi

# Use osascript to set wallpaper on all displays
osascript <<EOF
tell application "System Events"
    tell every desktop
        set picture to "$WALLPAPER_PATH"
    end tell
end tell
EOF

echo "Wallpaper set to: $WALLPAPER_PATH"
