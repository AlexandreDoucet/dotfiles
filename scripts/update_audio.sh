#!/bin/bash

# Define the preferred device keywords in order
Devices_identifier=("bluez5" "Family")

# Get the full wpctl status
status=$(wpctl status)

# Loop through device keywords
for keyword in "${Devices_identifier[@]}"; do
    # Find the device line containing the keyword
    device_line=$(echo "$status" | awk -v k="$keyword" '$0 ~ k && /Devices:/ {next} $0 ~ k && /Devices:/ {next} $0 ~ k && /[0-9]+\./ {print; exit}')

    if [ -n "$device_line" ]; then
        # Extract the device name
        device_name=$(echo "$device_line" | cut -d' ' -f2- | sed 's/\s\+\[.*//' | sed 's/^[^0-9]*[0-9]\+\.\s*//')

        # Now find the corresponding sink line and extract the sink ID
        sink_line=$(echo "$status" | awk -v dn="$device_name" '/Sinks:/ {flag=1; next} /^[[:space:]]*$/ {flag=0} flag && $0 ~ dn {print; exit}')

        # Extract the number at the beginning of that sink line
        sink_id=$(echo "$sink_line" | sed 's/^[^0-9]*\([0-9]\+\)\..*/\1/')

        if [ -n "$sink_id" ]; then
            echo "Setting default sink: $sink_id ($device_name)"
            wpctl set-default $sink_id
            break
        fi
    fi
done
