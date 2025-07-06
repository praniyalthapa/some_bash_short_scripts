#!/bin/bash

# Capture the output of df / in a variable
disk_info=$(df /)

# Extract the disk usage percentage (removing the % symbol)
disk_usage=$(echo "$disk_info" | awk 'NR==2 {gsub("%", "", $5); print $5}')

# Print the disk usage (which will be just the number without %)
if [ "$disk_usage" -gt 80 ]; then
    echo "Your disk is in danger: ${disk_usage}% used!"
else
    echo "Your disk space is fine: ${disk_usage}% used."
fi
