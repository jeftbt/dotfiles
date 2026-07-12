#!/bin/bash
#
# ╔╗╔╦╔═╗╦ ╦╔╦╗  ╔╦╗╔═╗╔╦╗╔═╗
# ║║║║║ ╦╠═╣ ║   ║║║║ ║ ║║║╣
# ╝╚╝╩╚═╝╩ ╩ ╩   ╩ ╩╚═╝═╩╝╚═╝
#

STATE_FILE="/tmp/hyprsunset-night-off"

if [ -f "$STATE_FILE" ]; then
    # Filtre kapalıydı → profili geri yükle
    hyprctl hyprsunset reset
    rm "$STATE_FILE"
    notify-send "Night Light" "On" -u low
else
    # Filtre açıktı → kapat
    hyprctl hyprsunset identity
    touch "$STATE_FILE"
    notify-send "Night Light" "Off" -u low
fi
