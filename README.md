# Waybar Configuration - Dotfiles

Modern, stylish waybar setup with dark theme, glassmorphism effects, and automated dependency installation.

## Quick Start

```bash
git clone <repo-url> ~/dotfiles-waybar
cd ~/dotfiles-waybar
bash install.sh
```

The install script will:
- ✅ Detect your Linux distribution
- ✅ Install all required dependencies (waybar, wofi, networkmanager, etc.)
- ✅ Copy config files to `~/.config/waybar`
- ✅ Apply GTK dark theme globally
- ✅ Configure shell environment

Then reload waybar:
```bash
pkill -SIGUSR2 waybar
```

## Features

- 🎨 **Modern Dark Theme** - Catppuccin-inspired color scheme
- ✨ **Glassmorphism Design** - Gradient backgrounds with transparency
- 📦 **Clean Modules** - Borderless, minimalist module styling
- 🌐 **Network Speed** - Real-time download/upload monitoring
- 🎮 **GPU Stats** - GPU usage, temperature, and memory
- 🔄 **Custom Scripts** - Network menu integration
- ⚡ **Smooth Animations** - Hover effects and transitions

## Modules (Left to Right)

- 🎯 **Menu Icon** - Click to open wofi app launcher
- 📊 **Workspaces** - Switch between workspaces
- 🕐 **Clock** - Date and time display
- 🌐 **Internet Speed** - Real-time network speed
- 📡 **Network** - WiFi/Ethernet status, click to connect
- 🔊 **Volume** - Audio control
- ☀ **Brightness** - Screen brightness
- 💾 **Memory** - RAM usage
- 🎮 **GPU** - GPU usage and temperature
- 🔋 **Battery** - Battery status
- 📦 **System Tray** - System notifications

## System Requirements

- Linux (Arch, Debian, Fedora, etc.)
- Hyprland or any Wayland compositor
- GPU (NVIDIA recommended for GPU stats)
- Nerd Font (for icons)

## Manual Installation

If you prefer manual installation, copy files to:
```
~/.config/waybar/
  ├── config           # Main configuration
  ├── style.css        # Styling and themes
  ├── network-menu.sh  # Network connection script
  ├── net_speed.sh     # Network speed meter
  └── waybar-gpu.sh    # GPU stats script
```

## Customization

### Change Colors

Edit `~/.config/waybar/style.css` and modify color variables:
```css
@define-color mauve  #cba6f7;   /* Purple */
@define-color blue   #89b4fa;   /* Blue */
@define-color sky    #89dceb;   /* Cyan */
@define-color green  #a6e3a1;   /* Green */
```

### Reorder Modules

Edit `~/.config/waybar/config` and change `modules-right`:
```json
"modules-right": [
  "custom/net-speed",
  "network",
  "pulseaudio",
  "backlight",
  "memory",
  "custom/gpu",
  "battery",
  "tray"
]
```

### Adjust Gaps/Spacing

Edit `~/.config/waybar/style.css`:
- `padding` - Icon padding
- `margin` - Space between modules
- `border-radius` - Corner roundness

## Troubleshooting

**Waybar not showing dark theme?**
```bash
pkill waybar
source ~/.zshrc  # or ~/.bashrc
waybar &
```

**Network menu not working?**
```bash
chmod +x ~/.config/waybar/network-menu.sh
chmod +x ~/.config/waybar/net_speed.sh
```

**GPU stats showing error?**
```bash
# Install NVIDIA utils
sudo pacman -S nvidia-utils  # Arch
# or
sudo apt install nvidia-utils  # Debian
```

**Icons not displaying?**
Install a Nerd Font:
```bash
# Arch
sudo pacman -S nerd-fonts

# Debian
apt install fonts-noto-color-emoji fonts-noto
```

## File Structure

```
~/.config/waybar/
├── config              # Module configuration
├── style.css           # Theme and styling
├── network-menu.sh     # Network connection (executable)
├── net_speed.sh        # Network speed monitor
├── waybar-gpu.sh       # GPU stats monitor
├── install.sh          # Automated installer
├── README.md           # Documentation
└── backup/             # Old config backups
```

## Dependencies

- **waybar** - Status bar
- **wofi** - Application launcher
- **hyprland** - Wayland compositor
- **networkmanager** - Network management
- **pavucontrol** - Audio control
- **jq** - JSON processor
- **bc** - Calculator (for network speed)
- **nvidia-utils** - GPU monitoring (optional)

## License

MIT

## Author

magilan

## Git

Track changes with git:
```bash
cd ~/.config/waybar
git add .
git commit -m "Custom waybar setup"
```

