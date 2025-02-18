#!/bin/bash

# Skrip untuk mengatur kecerahan dan menampilkan notifikasi menggunakan Dunst.

function get_brightness {
    # Mendapatkan kecerahan saat ini
    brightness=$(brightnessctl get)
    max_brightness=$(brightnessctl max)
    percentage=$((100 * brightness / max_brightness))
    echo $percentage
}

function send_notification {
    # Mengambil kecerahan dalam bentuk persentase
    brightness=$(get_brightness)

    # Menampilkan notifikasi dengan persentase kecerahan
    dunstify -i "notification-brightness" -r 2593 -t 1000 -u normal \
        "Brightness: $brightness%"  # Menampilkan persentase kecerahan
}

case $1 in
    up)
        # Menambah kecerahan
        brightnessctl s +5%
        send_notification
        ;;
    down)
        # Mengurangi kecerahan
        brightnessctl s 5%-
        send_notification
        ;;
esac
