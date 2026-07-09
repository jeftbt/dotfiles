# Clean Dotfiles Starter Kit

A clean, minimalist configuration starting point for Arch Linux running Hyprland. Built from scratch to replace pre-packaged, bloated setups.

## Structure

```text
├── dotconfig/            # Configs that go to ~/.config/
│   ├── dunst/            # Notification Daemon
│   │   └── dunstrc
│   ├── fastfetch/        # System Info Display
│   │   └── config.jsonc
│   ├── gtk-3.0/          # GTK3 Dark Theme
│   │   └── settings.ini
│   ├── gtk-4.0/          # GTK4 Dark Theme
│   │   └── settings.ini
│   ├── hypr/             # Hyprland Window Manager
│   │   ├── hyprland.conf
│   │   ├── hyprpaper.conf
│   │   ├── hyprlock.conf
│   │   └── hypridle.conf
│   ├── kitty/            # Kitty Terminal
│   │   └── kitty.conf
│   ├── rofi/             # Application Launcher (drun/run)
│   │   └── config.rasi
│   ├── starship/         # Starship Prompt
│   │   └── starship.toml
│   └── waybar/           # Top Status Bar
│       ├── config.jsonc
│       └── style.css
├── home/                 # Configs that go directly to ~/ (home folder)
│   └── .zshrc            # Clean shell config
└── install.sh            # Setup & symlink script (with automatic backups)
```

## How to Install

1. Clone or copy this repository to your system (e.g. at `~/dotfiles`).
2. Open a terminal and run the setup script:
   ```bash
   cd ~/dotfiles
   ./install.sh
   ```
3. The script will:
   - Check and prompt to install missing applications.
   - Detect existing configurations, back them up to `~/.config/cfg_backups/`, and replace them with symlinks to this directory.
   - Ask to enable SDDM as your login manager if it's installed.

## Keybindings (Default)

- **SUPER + T**: Open Kitty Terminal
- **SUPER + A**: Open Rofi Launcher (Apps)
- **SUPER + Tab**: Open Rofi Window Switcher
- **SUPER + E**: Open Yazi File Manager (runs in Kitty)
- **SUPER + Q**: Close active window
- **SUPER + W**: Toggle floating window
- **SUPER + F**: Toggle fullscreen
- **SUPER + V**: Clipboard History (Cliphist)
- **SUPER + P**: Screenshot selection (grim + slurp → clipboard & file)
- **Print**: Screenshot all screens (→ clipboard & file)
- **SUPER + Delete**: Exit Hyprland
- **Volume / Brightness Keys**: Working out-of-the-box (uses `pamixer` and `brightnessctl`)
