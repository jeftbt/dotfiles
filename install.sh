#!/usr/bin/env bash

# Set strict bash options
set -euo pipefail

# Output colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper output functions
info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Setup paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config/cfg_backups/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
CONFIG_DIR="$HOME/.config"

# Recommended applications list
PACKAGES=(
    hyprland xdg-desktop-portal-hyprland polkit-kde-agent sddm
    waybar rofi-wayland dunst hyprpaper hyprlock hypridle nwg-look
    kitty zsh zsh-syntax-highlighting zsh-autosuggestions starship neovim
    pipewire pipewire-pulse wireplumber pamixer brightnessctl pavucontrol
    grim slurp cliphist yazi fastfetch
    ttf-jetbrains-mono-nerd ttf-font-awesome
    # CPU: Intel i7-13700HX
    intel-ucode
    # GPU: Intel UHD 770 + NVIDIA RTX 4060 Max-Q
    mesa lib32-mesa vulkan-intel intel-media-driver
    nvidia-open-dkms nvidia-utils lib32-nvidia-utils nvidia-settings
    libva-nvidia-driver
    # Bluetooth
    bluez bluez-utils
)

# Step 1: Package installation check
check_packages() {
    info "Checking required packages..."
    local missing_pkgs=()

    for pkg in "${PACKAGES[@]}"; do
        if ! pacman -Qi "$pkg" &>/dev/null; then
            missing_pkgs+=("$pkg")
        fi
    done

    if [ ${#missing_pkgs[@]} -eq 0 ]; then
        success "All required packages are already installed!"
        return 0
    fi

    warn "The following recommended packages are missing:"
    for pkg in "${missing_pkgs[@]}"; do
        echo "  - $pkg"
    done

    echo
    read -rp "Would you like to install the missing packages now? (y/N): " choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        if command -v yay &>/dev/null; then
            info "Installing missing packages with yay..."
            yay -S "${missing_pkgs[@]}"
        elif command -v pacman &>/dev/null; then
            info "Installing missing packages with sudo pacman..."
            sudo pacman -S "${missing_pkgs[@]}"
        else
            error "No package manager (yay/pacman) found. Please install them manually."
            exit 1
        fi
    else
        warn "Proceeding without installing missing packages. Some configurations might not work properly."
    fi
}

# Step 2: Backup and Link creation helper
link_file() {
    local source_path="$1"
    local dest_path="$2"

    # Normalize paths
    local source_abs
    source_abs="$(realpath "$source_path")"

    # Create destination parent directories if they don't exist
    local dest_parent
    dest_parent="$(dirname "$dest_path")"
    mkdir -p "$dest_parent"

    # Check if target already exists
    if [ -e "$dest_path" ] || [ -L "$dest_path" ]; then
        # Check if it's already symlinked to the correct source
        if [ -L "$dest_path" ] && [ "$(readlink -f "$dest_path")" = "$source_abs" ]; then
            success "Already linked: $dest_path -> $source_abs"
            return 0
        fi

        # Backup existing target
        mkdir -p "$BACKUP_DIR"
        info "Backing up existing $dest_path to $BACKUP_DIR"
        mv "$dest_path" "$BACKUP_DIR/"
    fi

    # Create symlink
    ln -sfn "$source_abs" "$dest_path"
    success "Linked: $dest_path -> $source_abs"
}

# Step 3: Symlink all dotfiles
link_dotfiles() {
    info "Starting linking process..."

    # Enable dotglob to match hidden files (e.g. .zshrc)
    shopt -s dotglob

    # Link everything in dotconfig to ~/.config/
    if [ -d "$SCRIPT_DIR/dotconfig" ]; then
        for item in "$SCRIPT_DIR/dotconfig"/*; do
            [ -e "$item" ] || continue
            local name
            name="$(basename "$item")"
            link_file "$item" "$CONFIG_DIR/$name"
        done
    fi

    # Link everything in home to ~/
    if [ -d "$SCRIPT_DIR/home" ]; then
        for item in "$SCRIPT_DIR/home"/*; do
            [ -e "$item" ] || continue
            local name
            name="$(basename "$item")"
            link_file "$item" "$HOME/$name"
        done
    fi

    # Restore dotglob
    shopt -u dotglob
}

# Step 4: SDDM configuration helper
configure_sddm() {
    if pacman -Qi sddm &>/dev/null; then
        echo
        read -rp "Would you like to enable the SDDM login manager? (y/N): " sddm_choice
        if [[ "$sddm_choice" =~ ^[Yy]$ ]]; then
            info "Enabling SDDM service..."
            # Check if any display manager is already running
            if systemctl is-active --quiet gdm || systemctl is-active --quiet lightdm || systemctl is-active --quiet sddm; then
                warn "A display manager service is already active. Disabling active display manager first..."
                sudo systemctl disable gdm &>/dev/null || true
                sudo systemctl disable lightdm &>/dev/null || true
            fi
            sudo systemctl enable sddm
            success "SDDM has been enabled. It will start on the next reboot."
        fi
    fi
}

# Step 5: Wallpapers & Screenshots folder setup
create_user_folders() {
    info "Setting up user folders..."

    local wp_dir="$HOME/Pictures/wallpapers"
    if [ ! -d "$wp_dir" ]; then
        mkdir -p "$wp_dir"
        success "Created wallpapers directory at: $wp_dir"
    else
        info "Wallpapers directory already exists at: $wp_dir"
    fi

    local ss_dir="$HOME/Pictures/screenshots"
    if [ ! -d "$ss_dir" ]; then
        mkdir -p "$ss_dir"
        success "Created screenshots directory at: $ss_dir"
    else
        info "Screenshots directory already exists at: $ss_dir"
    fi
}

# Run Main
main() {
    echo -e "${BLUE}=== Clean Dotfiles Setup Script ===${NC}"
    echo

    # Check packages
    check_packages

    # Setup wallpapers & screenshots folders
    create_user_folders

    # Create backups & symlink dotfiles
    link_dotfiles

    # Option to enable SDDM
    configure_sddm

    echo
    success "Installation complete! Enjoy your clean, simple desktop environment."
    warn "Remember to place a wallpaper image named 'default.jpg' inside ~/Pictures/wallpapers/"
    warn "Otherwise, hyprpaper will not be able to load your background."
    if [ -d "$BACKUP_DIR" ]; then
        info "Any replaced configurations have been backed up to: $BACKUP_DIR"
    fi

    echo
    echo -e "${RED}=== NVIDIA CRITICAL SETUP ===${NC}"
    warn "Hyprland + NVIDIA için aşağıdaki adımları MUTLAKA uygulayın:"
    echo
    echo "  1. Kernel parametresi ekleyin:"
    echo "     - systemd-boot: /boot/loader/entries/*.conf → options satırına 'nvidia-drm.modeset=1' ekleyin"
    echo "     - GRUB: /etc/default/grub → GRUB_CMDLINE_LINUX_DEFAULT satırına 'nvidia-drm.modeset=1' ekleyin, sonra 'sudo grub-mkconfig -o /boot/grub/grub.cfg'"
    echo
    echo "  2. mkinitcpio modülleri:"
    echo "     /etc/mkinitcpio.conf → MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)"
    echo "     Sonra: sudo mkinitcpio -P"
    echo
    echo "  3. Bluetooth servisini başlatın:"
    echo "     sudo systemctl enable --now bluetooth.service"
    echo
}

main "$@"
