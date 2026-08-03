#!/usr/bin/env bash
mkdir -p "$HOME/Pictures/screenshots"
GEOM=$(slurp 2>/dev/null)
if [ -n "$GEOM" ]; then
    grim -t ppm -g "$GEOM" - | satty --filename - --output-filename "$HOME/Pictures/screenshots/screenshot_%Y%m%d_%H%M%S.png"
fi
