#!/usr/bin/env python3
import subprocess
import csv
import json


def main(querry_name):
    result = subprocess.run(
        ["hyprctl", "devices", "-j"], capture_output=True
    ).stdout.decode("utf-8")

    data = json.loads(result)
    for device in data["keyboards"]:
        if device["main"] != False:
            if querry_name:
                print(device[querry_name])
            else:
                print(device)


import sys

if __name__ == "__main__":

    if len(sys.argv) > 1 and (
        sys.argv[1].strip().lower() == "name"
        or sys.argv[1].lower().strip() == "active_keymap"
    ):
        main(sys.argv[1].strip().lower())
    else:
        main(None)
