#!/usr/bin/env bash

# Prints the active keyboard layout for Waybar

layout=$(hyprctl devices | awk '
    /Keyboard at/ {found=0}
    /main: yes/ {found=1}
    found && /active keymap:/ {
        for (i=3;i<=NF;i++)
            printf "%s%s", $i, (i<NF ? " " : "\n")
        exit
    }
')

if [[ -z "$layout" ]]; then
  layout=$(hyprctl devices | awk '
        /active keymap:/ {
            print $3
            exit
        }
    ')
fi

case "$layout" in
"English") echo "US" ;;
"Canadian") echo "CA" ;;
*) echo "$layout" ;;
esac
