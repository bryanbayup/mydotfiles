#!/bin/zsh

LOGFILE="$HOME/.config/i3/study-reminder.log"
echo "Script started at $(date)" >> "$LOGFILE"

while true; do
    echo "Reminder triggered at $(date)" >> "$LOGFILE"
    i3-nagbar -m "📚 Waktunya belajar! Fokus ya! 🚀" -t warning
    sleep 3600
done
