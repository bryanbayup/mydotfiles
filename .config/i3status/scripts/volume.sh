#!/bin/bash
# Get current volume
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')

# Set minimum and maximum volume
min_volume=10
max_volume=100

if [[ $1 == "up" ]]; then
    # Increase volume by 10%, but not above max_volume
    new_volume=$((volume + 10))
    if [[ $new_volume -gt $max_volume ]]; then
        new_volume=$max_volume
    fi
elif [[ $1 == "down" ]]; then
    # Decrease volume by 10%, but not below min_volume
    new_volume=$((volume - 10))
    if [[ $new_volume -lt $min_volume ]]; then
        new_volume=$min_volume
    fi
else
    exit 1
fi

# Set the new volume
pactl set-sink-volume @DEFAULT_SINK@ ${new_volume}%
