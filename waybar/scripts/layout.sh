#!/usr/bin/env bash
# ~/.config/waybar/scripts/layout.sh
# Prints the active keyboard layout for Waybar

# Use absolute path to hyprctl
HYPRCTL=$(which hyprctl)
if [[ -z "$HYPRCTL" ]]; then
    echo "ERR"
    exit 1
fi

# Ensure PATH is sane for Waybar
export PATH=/usr/bin:/bin:/usr/local/bin

# Get the active keymap from the main keyboard
layout=$($HYPRCTL devices | awk '
    /Keyboard at/ {found=0}
    /main: yes/ {found=1}
    found && /active keymap:/ {
        # print all fields after "active keymap:"
        for (i=3;i<=NF;i++) printf "%s%s", $i, (i<NF ? " " : "\n")
        exit
    }
')

# Fallback if no main keyboard found
if [[ -z "$layout" ]]; then
    layout=$($HYPRCTL devices | awk '/active keymap:/ {print $3; exit}')
fi

# Map full names to short codes
case "$layout" in
    "English") echo "US" ;;
    "Canadian") echo "CA" ;;
    *) echo "$layout" ;; # fallback: print full name
esac
