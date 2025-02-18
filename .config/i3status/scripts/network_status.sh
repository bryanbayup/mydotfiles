#!/bin/bash
# Skrip ini mengecek status koneksi jaringan:
# - Jika interface enp2s0 (Ethernet) aktif, maka output "LAN"
# - Jika tidak, dan interface wlan0 (WiFi) aktif, maka output "WiFi: <SSID>" (jika SSID tersedia)
# - Jika tidak ada koneksi, maka output "No Network"

# Pastikan nama interface sesuai dengan hasil `ip a`
ethernet_up=$(ip link show enp2s0 | grep "state UP")
wifi_up=$(ip link show wlan0 | grep "state UP")

if [[ -n "$ethernet_up" ]]; then
    echo "LAN"
elif [[ -n "$wifi_up" ]]; then
    ssid=$(iwgetid -r)
    if [[ -n "$ssid" ]]; then
        echo "WiFi: $ssid"
    else
        echo "WiFi"
    fi
else
    echo "No Network"
fi
