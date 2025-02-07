#!/bin/bash

# Membaca kapasitas baterai dan statusnya
battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# Notifikasi jika baterai mencapai 20% atau kurang
if [ "$battery_capacity" -le 20 ] && [ "$battery_status" = "Discharging" ]; then
    dunstify -u critical "Low Battery" "Battery is at ${battery_capacity}%. Please plug in your charger."

# Notifikasi jika baterai mencapai 99% atau lebih
elif [ "$battery_capacity" -ge 99 ] && [ "$battery_status" = "Charging" ]; then
    dunstify -u normal "Battery Full" "Battery is fully charged at ${battery_capacity}%. You can unplug your charger."
fi

