# Dotfiles

Clean and minimalist configuration files for Arch Linux running Hyprland.

## Installation

To install the dotfiles and required packages automatically, clone the repository and run `install.sh`:

```bash
git clone https://github.com/jeftbt/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

> [!NOTE]
> **Hybrid Graphics (Intel + NVIDIA) Setup:**
> This configuration relies on the Intel iGPU by default for desktop rendering (for lower power consumption and maximum system stability).
> 
> * **NVIDIA Rendering:** If you prefer to force full desktop rendering on the NVIDIA dGPU instead, you can add the following lines to `.config/hypr/hyprland/env.lua`:
>   ```lua
>   hl.env("LIBVA_DRIVER_NAME", "nvidia")
>   hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
>   ```
> * **Boot Stability (Early KMS):** To prevent boot delays or blank screens, make sure the `i915` module is loaded before NVIDIA modules in `/etc/mkinitcpio.conf`:
>   ```sh
>   MODULES=(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)
>   ```

### Automatic Setup Details

The script performs the following actions:
1. **Installs required packages:**
   ```bash
   sudo pacman -S --needed hyprland swaybg hyprlock hypridle hyprsunset \
     alacritty waybar dunst zsh starship yazi fastfetch grim slurp cliphist \
     pamixer brightnessctl cava helix blueman satty eza bat zoxide fzf wf-recorder hyprpicker
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
- **Wallpaper & Screen Lock:** [Swaybg](https://github.com/swaywm/swaybg), [Hyprlock](https://github.com/hyprwm/hyprlock), [Hypridle](https://github.com/hyprwm/hypridle)
- **Shell & Prompt:** [Zsh](https://github.com/zsh-users/zsh), [Starship](https://github.com/starship/starship)
- **File Manager:** [Yazi](https://github.com/sxyazi/yazi)
- **System Info Display:** [Fastfetch](https://github.com/fastfetch-cli/fastfetch)
- **Screenshot & Annotation:** [Grim](https://github.com/emersion/grim), [Slurp](https://github.com/emersion/slurp), [Satty](https://github.com/gabm/satty)
- **Screen Recorder:** [wf-recorder](https://github.com/ammen99/wf-recorder)
- **Clipboard:** [Cliphist](https://github.com/sentriz/cliphist)
- **Text Editor:** [Helix](https://github.com/helix-editor/helix)
- **Audio & Brightness Control:** [Pamixer](https://github.com/cdemoulins/pamixer), [Brightnessctl](https://github.com/Hummer666/brightnessctl)
- **Audio Visualizer:** [Cava](https://github.com/karlstav/cava)
- **CLI Enhancements:** [Eza](https://github.com/eza-community/eza), [Bat](https://github.com/sharkdp/bat), [Zoxide](https://github.com/ajeetdsouza/zoxide), [FZF](https://github.com/junegunn/fzf)
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
- **SUPER + P:** Screenshot Selection (Grim + Slurp + Satty)
- **Print:** Screenshot Entire Screen
- **SUPER + R:** Toggle Screen Recorder (wf-recorder)
- **SUPER + SHIFT + N:** Toggle Night Mode (Hyprsunset)
- **SUPER + Delete:** Exit Hyprland
