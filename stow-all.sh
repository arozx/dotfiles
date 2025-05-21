#!/bin/bash

for dir in */; do
    dir_name="${dir%/}"

    # Skip the "wallpaper" directory
    [[ "$dir_name" == "wallpapers" ]] && continue
    [[ "$dir_name" == "wallpaper" ]] && continue
    [[ "$dir_name" == "walls" ]] && continue

    echo "Stowing: $dir_name"
    stow -v "$dir_name" --adopt
done
