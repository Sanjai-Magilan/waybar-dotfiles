#!/bin/bash

# Dotfiles Installation Script
# This script installs all dependencies and configures waybar

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Waybar Dotfiles Installer ===${NC}\n"

# Detect package manager
if command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -S --noconfirm"
    echo -e "${GREEN}✓ Detected: Arch Linux${NC}\n"
elif command -v apt &> /dev/null; then
    PKG_MANAGER="apt"
    INSTALL_CMD="sudo apt install -y"
    echo -e "${GREEN}✓ Detected: Debian/Ubuntu${NC}\n"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
    INSTALL_CMD="sudo dnf install -y"
    echo -e "${GREEN}✓ Detected: Fedora${NC}\n"
else
    echo -e "${RED}✗ Package manager not found. Please install dependencies manually.${NC}"
    exit 1
fi

# Dependencies
DEPENDENCIES=(
    "waybar"
    "wofi"
    "hyprland"
    "networkmanager"
    "pavucontrol"
    "jq"
    "bc"
    "nvidia-utils"
)

echo -e "${BLUE}Installing dependencies...${NC}"
for dep in "${DEPENDENCIES[@]}"; do
    if command -v "$dep" &> /dev/null; then
        echo -e "${GREEN}✓ $dep${NC} (already installed)"
    else
        echo -e "${BLUE}Installing $dep...${NC}"
        $INSTALL_CMD "$dep" || true
    fi
done

echo -e "\n${GREEN}✓ Dependencies installed!${NC}\n"

# Install waybar config
WAYBAR_CONFIG_DIR="$HOME/.config/waybar"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}Setting up waybar configuration...${NC}"

# Backup existing config if it exists
if [ -d "$WAYBAR_CONFIG_DIR" ]; then
    BACKUP_DIR="${WAYBAR_CONFIG_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${BLUE}Backing up existing config to: $BACKUP_DIR${NC}"
    mv "$WAYBAR_CONFIG_DIR" "$BACKUP_DIR"
fi

# Copy config files
mkdir -p "$WAYBAR_CONFIG_DIR"
cp "$SCRIPT_DIR/config" "$WAYBAR_CONFIG_DIR/"
cp "$SCRIPT_DIR/style.css" "$WAYBAR_CONFIG_DIR/"
cp "$SCRIPT_DIR/network-menu.sh" "$WAYBAR_CONFIG_DIR/"
cp "$SCRIPT_DIR/net_speed.sh" "$WAYBAR_CONFIG_DIR/"
cp "$SCRIPT_DIR/waybar-gpu.sh" "$WAYBAR_CONFIG_DIR/"

# Make scripts executable
chmod +x "$WAYBAR_CONFIG_DIR"/*.sh

echo -e "${GREEN}✓ Config files installed!${NC}\n"

# Apply theme settings
echo -e "${BLUE}Applying theme settings...${NC}"

# GTK Settings
mkdir -p "$HOME/.config/gtk-4.0"
cat > "$HOME/.config/gtk-4.0/settings.ini" << 'EOF'
[Settings]
gtk-application-prefer-dark-theme=true
gtk-cursor-blink=true
gtk-cursor-blink-time=1000
gtk-cursor-theme-name=breeze_cursors
gtk-cursor-theme-size=24
gtk-decoration-layout=icon:minimize,maximize,close
gtk-enable-animations=true
gtk-font-name=JetBrains Mono, 11
gtk-icon-theme-name=Adwaita
gtk-primary-button-warps-slider=true
gtk-sound-theme-name=ocean
gtk-xft-dpi=98304
gtk-dialogs-use-header=true
gtk-csd-content-border=8
gtk-csd-header-border=0
gtk-theme-name=Breeze-Dark
EOF

# Add to .zshrc if using zsh
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "GTK_THEME=Breeze-Dark" "$HOME/.zshrc"; then
        cat >> "$HOME/.zshrc" << 'EOF'

# Dark theme for GTK apps
export GTK_THEME=Breeze-Dark
export GTK_DATA_PREFIX=/usr/share
EOF
        echo -e "${GREEN}✓ Added dark theme to .zshrc${NC}"
    fi
fi

# Add to .bashrc if using bash
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "GTK_THEME=Breeze-Dark" "$HOME/.bashrc"; then
        cat >> "$HOME/.bashrc" << 'EOF'

# Dark theme for GTK apps
export GTK_THEME=Breeze-Dark
export GTK_DATA_PREFIX=/usr/share
EOF
        echo -e "${GREEN}✓ Added dark theme to .bashrc${NC}"
    fi
fi

# XFCE Theme
xfconf-query -c xfce4-appearance -p /Net/ThemeName -s "Breeze-Dark" --create -t string 2>/dev/null || true

echo -e "\n${GREEN}✓ Theme settings applied!${NC}\n"

echo -e "${GREEN}=== Installation Complete ===${NC}"
echo -e "\n${BLUE}Next steps:${NC}"
echo "1. Reload waybar: pkill -SIGUSR2 waybar"
echo "2. Or restart your desktop environment"
echo "3. Customize colors in: ~/.config/waybar/style.css"
echo ""
echo -e "${BLUE}Waybar location:${NC} ~/.config/waybar"
echo -e "${BLUE}Config file:${NC} ~/.config/waybar/config"
echo -e "${BLUE}Styles:${NC} ~/.config/waybar/style.css"
