# Dotfiles

Clean and minimalist configuration files for Arch Linux running Hyprland.

## Installation / Kurulum

To install the dotfiles and required packages automatically, clone the repository and run `install.sh`:

```bash
git clone https://github.com/jeftbt/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

### Automatic Setup Details / Kurulum Detayları

The script performs the following actions:
1. **Installs required packages:**
   ```bash
   sudo pacman -S --needed hyprland hyprpaper hyprlock hypridle hyprsunset \
     alacritty waybar dunst zsh starship yazi fastfetch grim slurp cliphist \
     pamixer brightnessctl cava helix
   ```
2. **Deploys configuration files:**
   - Copies `dotconfig/*` to `~/.config/`
   - Copies `home/*` to `~/`

## Applications Used

- **Window Manager:** Hyprland
- **Terminal:** Alacritty
- **Status Bar:** Waybar
- **Application Launcher:** Hyprlauncher
- **Notification Daemon:** Dunst
- **Wallpaper & Screen Lock:** Hyprpaper, Hyprlock, Hypridle
- **Shell & Prompt:** Zsh, Starship
- **File Manager:** Yazi
- **System Info Display:** Fastfetch
- **Screenshot & Clipboard:** Grim, Slurp, Cliphist
- **Audio & Brightness Control:** Pamixer, Brightnessctl
- **Theme:** GTK3 / GTK4 Dark Theme

## Keybindings

- **SUPER + T:** Open Alacritty Terminal
- **SUPER + A:** Open Hyprlauncher
- **SUPER + E:** Open Yazi File Manager
- **SUPER + Q:** Close Active Window
- **SUPER + W:** Toggle Floating Window
- **SUPER + SHIFT + W:** Wallpaper Selector
- **SUPER + F:** Toggle Fullscreen Mode
- **SUPER + V:** Clipboard History (Cliphist)
- **SUPER + P:** Screenshot Selection (Grim + Slurp)
- **Print:** Screenshot Entire Screen
- **SUPER + Delete:** Exit Hyprland
