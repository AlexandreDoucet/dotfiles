#!/bin/bash
# ~/.config/waybar/scripts/layout.sh
# Detects active layout from Hyprland main keyboard

layout=$(hyprctl devices | awk '
  /Keyboard at/ {found=0}
  /main: yes/ {found=1}
  found && /active keymap:/ {
    # print all fields after "active keymap:"
    for (i=3;i<=NF;i++) printf "%s%s", $i, (i<NF ? " " : "\n")
    exit
  }
')

# Convert to short layout
case "$layout" in
  "English (US)") echo "US" ;;
  "Canadian (CA)") echo "CA" ;;
  *) echo "$layout" ;;
esac
