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

- **Window Manager:** [Hyprland](https://github.com/hyprwm/Hyprland)
- **Terminal:** [Alacritty](https://github.com/alacritty/alacritty)
- **Status Bar:** [Waybar](https://github.com/Alexays/Waybar)
- **Application Launcher:** [Hyprlauncher](https://github.com/hyprwm/hyprlauncher)
- **Notification Daemon:** [Dunst](https://github.com/dunst-project/dunst)
- **Wallpaper & Screen Lock:** [Hyprpaper](https://github.com/hyprwm/hyprpaper), [Hyprlock](https://github.com/hyprwm/hyprlock), [Hypridle](https://github.com/hyprwm/hypridle)
- **Shell & Prompt:** [Zsh](https://github.com/zsh-users/zsh), [Starship](https://github.com/starship/starship)
- **File Manager:** [Yazi](https://github.com/sxyazi/yazi)
- **System Info Display:** [Fastfetch](https://github.com/fastfetch-cli/fastfetch)
- **Screenshot & Clipboard:** [Grim](https://github.com/emersion/grim), [Slurp](https://github.com/emersion/slurp), [Cliphist](https://github.com/sentriz/cliphist)
- **Text Editor:** [Helix](https://github.com/helix-editor/helix)
- **Audio & Brightness Control:** [Pamixer](https://github.com/cdemoulins/pamixer), [Brightnessctl](https://github.com/Hummer666/brightnessctl)
- **Audio Visualizer:** [Cava](https://github.com/karlstav/cava)
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
