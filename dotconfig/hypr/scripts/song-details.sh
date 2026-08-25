#!/usr/bin/env bash

# Oynatıcı durumunu kontrol et (Playing / Paused)
status=$(playerctl status 2>/dev/null)

if [ "$status" != "Playing" ] && [ "$status" != "Paused" ]; then
    exit 0
fi

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

# Sanatçı ve şarkı başlığı kontrolü
if [ -n "$artist" ] && [ -n "$title" ]; then
    info="$artist • $title"
elif [ -n "$title" ]; then
    info="$title"
elif [ -n "$artist" ]; then
    info="$artist"
else
    exit 0
fi

# Uzunluk sınırı (45 karakter)
MAX_LEN=45
if [ ${#info} -gt $MAX_LEN ]; then
    info="${info:0:$((MAX_LEN - 3))}..."
fi

echo "$info"
