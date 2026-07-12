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

# Recommended applications list (Hem Pacman hem AUR paketleri karışık)
PACKAGES=(
    hyprland xdg-desktop-portal-hyprland polkit-kde-agent sddm
    waybar rofi-wayland dunst hyprpaper hyprlock hypridle nwg-look wlogout
    ghostty zsh zsh-syntax-highlighting zsh-autosuggestions starship neovim
    pipewire pipewire-pulse wireplumber pamixer brightnessctl pavucontrol
    grim slurp cliphist yazi fastfetch
    ttf-jetbrains-mono-nerd ttf-font-awesome
    catppuccin-gtk-theme-mocha
    catppuccin-cursors-mocha
    # CPU: Intel i7-13700HX
    intel-ucode
    # GPU: Intel UHD 770 + NVIDIA RTX 4060 Max-Q
    mesa lib32-mesa vulkan-intel intel-media-driver
    nvidia-open-dkms nvidia-utils lib32-nvidia-utils nvidia-settings
    libva-nvidia-driver
    # Bluetooth
    bluez bluez-utils
)

# Step 0: Ensure yay is installed
ensure_yay() {
    if ! command -v yay &>/dev/null; then
        warn "AUR helper 'yay' is not installed. Setting up 'yay' first..."
        
        # Install dependencies for building yay
        info "Installing base-devel and git..."
        sudo pacman -S --needed --noconfirm base-devel git

        local tmp_yay
        tmp_yay=$(mktemp -d)
        info "Cloning and building yay..."
        git clone https://aur.archlinux.org/yay.git "$tmp_yay"
        (cd "$tmp_yay" && makepkg -si --noconfirm)
        rm -rf "$tmp_yay"
        
        success "'yay' has been successfully installed!"
    fi
}

# Step 1: Package installation check (Using yay for both repo and AUR)
check_packages() {
    ensure_yay

    info "Checking required packages (Official & AUR)..."
    local missing_pkgs=()

    for pkg in "${PACKAGES[@]}"; do
        # yay -Q hem yerel hem AUR paketlerini kontrol edebilir
        if ! yay -Q "$pkg" &>/dev/null; then
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
        info "Installing missing packages with yay..."
        # --needed parametresi zaten kurulu olanları tekrar kurmaz
        yay -S --needed "${missing_pkgs[@]}"
    else
        warn "Proceeding without installing missing packages. Some configurations might not work properly."
    fi
}

# Step 2: Backup and Link creation helper
link_file() {
    local source_path="$1"
    local dest_path="$2"

    local source_abs
    source_abs="$(realpath "$source_path")"

    local dest_parent
    dest_parent="$(dirname "$dest_path")"
    mkdir -p "$dest_parent"

    if [ -e "$dest_path" ] || [ -L "$dest_path" ]; then
        if [ -L "$dest_path" ] && [ "$(readlink -f "$dest_path")" = "$source_abs" ]; then
            success "Already linked: $dest_path -> $source_abs"
            return 0
        fi

        mkdir -p "$BACKUP_DIR"
        info "Backing up existing $dest_path to $BACKUP_DIR"
        mv "$dest_path" "$BACKUP_DIR/"
    fi

    ln -sfn "$source_abs" "$dest_path"
    success "Linked: $dest_path -> $source_abs"
}

# Step 3: Symlink all dotfiles
link_dotfiles() {
    info "Starting linking process..."

    shopt -s dotglob

    if [ -d "$SCRIPT_DIR/dotconfig" ]; then
        for item in "$SCRIPT_DIR/dotconfig"/*; do
            [ -e "$item" ] || continue
            local name
            name="$(basename "$item")"
            link_file "$item" "$CONFIG_DIR/$name"
        done
    fi

    if [ -d "$SCRIPT_DIR/home" ]; then
        for item in "$SCRIPT_DIR/home"/*; do
            [ -e "$item" ] || continue
            local name
            name="$(basename "$item")"
            link_file "$item" "$HOME/$name"
        done
    fi

    shopt -u dotglob
}

# Step 4: SDDM configuration helper
configure_sddm() {
    # sddm'in kurulu olup olmadığını yay -Q ile kontrol ediyoruz
    if yay -Q sddm &>/dev/null; then
        echo
        read -rp "Would you like to enable the SDDM login manager? (y/N): " sddm_choice
        if [[ "$sddm_choice" =~ ^[Yy]$ ]]; then
            info "Enabling SDDM service..."
            if systemctl is-active --quiet gdm || systemctl is-active --quiet lightdm || systemctl is-active --quiet sddm; then
                warn "A display manager service is already active. Disabling active display manager first..."
                sudo systemctl disable gdm &>/dev/null || true
                sudo systemctl disable lightdm &>/dev/null || true
            fi
            sudo systemctl enable sddm
            success "SDDM has been enabled. It will start on the next reboot."

            echo
            info "Select an SDDM theme to install and configure:"
            echo "  1) sddm-silent-theme (Minimalist theme)"
            echo "  2) sddm-astronaut-theme (Modern theme via official setup script)"
            echo "  3) Skip theme configuration"
            read -rp "Enter choice [1-3] (default: 3): " theme_choice
            theme_choice=${theme_choice:-3}

            if [[ "$theme_choice" == "1" ]]; then
                if [ ! -d "/usr/share/sddm/themes/silent" ]; then
                    info "sddm-silent-theme is not installed. Installing via yay..."
                    yay -S --noconfirm sddm-silent-theme || true

                    if [ ! -d "/usr/share/sddm/themes/silent" ]; then
                        warn "Installing via yay failed. Cloning Git repository..."
                        local tmp_dir
                        tmp_dir=$(mktemp -d)
                        if git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM "$tmp_dir"; then
                            (cd "$tmp_dir" && ./install.sh)
                            rm -rf "$tmp_dir"
                        else
                            error "Failed to clone SilentSDDM repository."
                        fi
                    fi
                fi

                if [ -d "/usr/share/sddm/themes/silent" ]; then
                    info "Configuring sddm-silent-theme..."
                    sudo mkdir -p /etc/sddm.conf.d
                    sudo tee /etc/sddm.conf.d/theme.conf >/dev/null <<EOF
[General]
InputMethod=qtvirtualkeyboard
GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard

[Theme]
Current=silent
EOF
                    success "sddm-silent-theme has been configured successfully!"
                else
                    error "Could not verify theme installation at /usr/share/sddm/themes/silent. Skipping theme configuration."
                fi
            elif [[ "$theme_choice" == "2" ]]; then
                info "Starting installation of sddm-astronaut-theme..."
                info "This will run Keyitdev's official installation script: https://github.com/Keyitdev/sddm-astronaut-theme"
                info "Please follow the prompts on the screen to choose your options/sub-themes."
                echo

                if bash -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"; then
                    success "sddm-astronaut-theme setup script completed successfully!"
                else
                    error "sddm-astronaut-theme setup script returned an error."
                fi
            else
                info "Skipping SDDM theme configuration."
            fi
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

    # Check and install packages via yay
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
