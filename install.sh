#!/usr/bin/env bash

set -e

echo "==> Gerekli paketler yükleniyor..."
sudo pacman -S --needed hyprland swaybg hyprlock hypridle hyprsunset hyprpolkitagent \
  alacritty waybar dunst zsh starship yazi fastfetch grim slurp cliphist rofi wl-clipboard \
  pamixer brightnessctl cava helix blueman satty eza bat zoxide fzf wf-recorder hyprpicker \
  pipewire pipewire-pulse wireplumber udiskie playerctl power-profiles-daemon \
  ttf-jetbrains-mono-nerd zsh-autosuggestions zsh-syntax-highlighting

echo "==> Konfigürasyon dosyaları ~/.config dizinine kopyalanıyor..."
mkdir -p ~/.config
cp -r dotconfig/* ~/.config/

if [ -d "home" ]; then
    echo "==> Ev dizini konfigürasyonları kopyalanıyor..."
    cp -r home/. ~/
fi

echo "==> Kurulum başarıyla tamamlandı!"
