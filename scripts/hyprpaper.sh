#!/usr/bin/env bash

sleep 2

WALLPAPER_DIR="$HOME/Pictures/wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a list of wallpapers excluding the current one
#WALLPAPERS=($(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")")) # for recursive search
WALLPAPERS=($(find "$WALLPAPER_DIR" -maxdepth 1 -type f ! -name "$(basename "$CURRENT_WALL")"))

if [[ ${#WALLPAPERS[@]} -eq 0 ]]; then
  # If no other wallpapers exist, fallback to the current one
  WALLPAPER="$CURRENT_WALL"
else
  # Otherwise, select a random wallpaper
  WALLPAPER=$(printf "%s\n" "${WALLPAPERS[@]}" | shuf -n 1)
fi

# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"
