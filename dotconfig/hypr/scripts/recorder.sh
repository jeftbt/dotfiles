#!/usr/bin/env bash

SAVE_DIR="$HOME/Videos/Recordings"

if pgrep -x "wf-recorder" > /dev/null; then
    pkill -INT -x wf-recorder
    notify-send "Kayıt Durduruldu" -t 1500 -u low -i media-tape
else
    mkdir -p "$SAVE_DIR"
    FILE="$SAVE_DIR/recording_$(date +'%Y%m%d_%H%M%S').mp4"
    
    AUDIO_DEVICE="$(pactl get-default-sink 2>/dev/null).monitor"

    notify-send "Kayıt Başladı" -t 1500 -u low -i media-record
    
    if [ -n "$AUDIO_DEVICE" ]; then
        wf-recorder --audio="$AUDIO_DEVICE" -f "$FILE" &
    else
        wf-recorder --audio -f "$FILE" &
    fi
fi
