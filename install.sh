#!/usr/bin/env bash

set -e

echo "==> Gerekli paketler yükleniyor..."
sudo pacman -S --needed hyprland hyprpaper hyprlock hypridle hyprsunset \
  alacritty waybar dunst zsh starship yazi fastfetch grim slurp cliphist \
  pamixer brightnessctl cava helix

echo "==> Konfigürasyon dosyaları ~/.config dizinine kopyalanıyor..."
mkdir -p ~/.config
cp -r dotconfig/* ~/.config/

if [ -d "home" ]; then
    echo "==> Ev dizini konfigürasyonları kopyalanıyor..."
    cp -rn home/. ~/ 2>/dev/null || true
fi

echo "==> Kurulum başarıyla tamamlandı!"
