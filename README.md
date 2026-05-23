# Waybar Configuration

Modern, stylish waybar setup with dark theme and glassmorphism effects.

## Features

- 🎨 **Modern Dark Theme** - Catppuccin-inspired color scheme
- ✨ **Glassmorphism Design** - Gradient backgrounds with transparency
- 📦 **Clean Modules** - Borderless, minimalist module styling
- 🔄 **Custom Scripts** - Network menu integration
- ⚡ **Smooth Animations** - Hover effects and transitions

## Files

- `config` - Main waybar configuration with module setup
- `style.css` - Complete styling with themes and gradients
- `network-menu.sh` - Custom network selection script

## Dependencies

- waybar
- hyprland (for workspace integration)
- networkmanager (for network menu)
- wofi (for application launcher)
- nerd-fonts (for icons)

## Installation

1. Clone or copy to `~/.config/waybar/`
2. Make sure all dependencies are installed
3. Reload waybar: `pkill -SIGUSR2 waybar`

## Keybindings

- Click network icon → Open network menu
- Click launcher → Open wofi app launcher

## Customization

Edit `style.css` to change colors. Main color variables:
- `@mauve` - Purple accents
- `@blue` - Blue accents
- `@sky` - Cyan accents
- `@green` - Green accents

## License

MIT
