#!/bin/bash

# Mengambil persentase baterai
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Menentukan status baterai
if [ "$battery_percentage" -le 15 ]; then
    # Jika baterai di bawah 15%, kirimkan peringatan
    notify-send -u critical -i battery-low "Baterai rendah" "Baterai tinggal $battery_percentage%"
elif [ "$battery_percentage" -ge 100 ]; then
    # Jika baterai 100%, kirimkan notifikasi
    notify-send -u normal -i battery-full "Baterai penuh" "Baterai sudah penuh ($battery_percentage%)"
fi

