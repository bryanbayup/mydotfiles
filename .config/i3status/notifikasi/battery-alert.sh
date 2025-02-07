#!/bin/bash

while true; do
    BATTERY_LEVEL=$(< /sys/class/power_supply/BAT0/capacity)
    BATTERY_STATUS=$(< /sys/class/power_supply/BAT0/status)

    if [[ "$BATTERY_LEVEL" -le 20 && "$BATTERY_STATUS" == "Discharging" ]]; then
        i3-nagbar -m "⚠️ Baterai hampir habis! ($BATTERY_LEVEL%) Colokkan charger!" -t warning
        paplay /usr/share/sounds/710280__dan2008__no-battery.wav
        # Untuk ALSA, jika paplay tidak bekerja:
        # aplay ~/.config/i3/alert.wav
    fi

    sleep 60
done
