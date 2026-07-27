#!/bin/bash
#
# ╔╗╔╦╔═╗╦ ╦╔╦╗  ╔╦╗╔═╗╔╦╗╔═╗
# ║║║║║ ╦╠═╣ ║   ║║║║ ║ ║║║╣
# ╝╚╝╩╚═╝╩ ╩ ╩   ╩ ╩╚═╝═╩╝╚═╝
#

STATE_FILE="/tmp/hyprsunset-night-off"

if [ -f "$STATE_FILE" ]; then
    # Filtre kapalıydı → gece modunu aç (hyprsunset çalıştır)
    killall -w hyprsunset 2>/dev/null || true
    hyprctl dispatch exec "hyprsunset"
    rm "$STATE_FILE"
    notify-send "Night Light" "On" -u low
else
    # Filtre açıktı → gece modunu kapat (hyprsunset sonlandır)
    killall -w hyprsunset 2>/dev/null || true
    touch "$STATE_FILE"
    notify-send "Night Light" "Off" -u low
fi
