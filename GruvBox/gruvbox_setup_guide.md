# Gruvbox Theme Setup - Linux Mint Configuration

## Overview
Complete Gruvbox-themed desktop environment setup for Linux Mint with consistent theming across all applications and components.

## Theme Components

### System Theme
- **Base Theme**: Gruvbox Dark
- **Icon Theme**: Papirus (Cyan variant)
- **Folder Colors**: Cyan Papirus folders
- **Window Manager**: Native Gruvbox theme

### Fonts Configuration
- **System Font**: SF Pro Display
- **Terminal Font**: JetBrains Mono
- **VS Code Font**: LigaSFMono Nerd Font (SF Mono variant with ligatures)
- **Monospace Fallback**: JetBrains Mono

### Applications Theming

#### VS Code Settings
- **Theme**: Ayu Green Dark
- **Font**: LigaSFMono Nerd Font
- **Title Bar**: Custom (GTK integrated)
- **Menu Bar**: Hidden/Toggle

#### Terminal Configuration
- **Font**: JetBrains Mono
- **Color Scheme**: Gruvbox Dark
- **Background**: Gruvbox dark background (#282828)

#### Launcher (Ulauncher)
- **Theme**: Gruvbox variant
- **Integration**: System theme aware
- **Font**: SF Pro Display

#### Dock (Plank)
- **Theme**: Native Gruvbox theme
- **Transparency**: Enabled
- **Icon Size**: Medium (48px recommended)
- **Position**: Bottom

## File Structure
```
gruvbox-setup/
├── README.md (this file)
├── vscode/
│   ├── settings.json
│   ├── extensions.txt
│   └── keybindings.json
├── terminal/
│   ├── gruvbox.colorscheme
│   └── terminal-settings.txt
├── gtk/
│   ├── gtk-theme-install.sh
│   └── theme-config.txt
├── fonts/
│   ├── font-install.sh
│   └── font-list.txt
├── ulauncher/
│   ├── gruvbox-theme/
│   └── theme-install.txt
├── plank/
│   ├── gruvbox-dock-theme/
│   └── dock-config.txt
└── wallpapers/
    └── gruvbox-wallpapers/
```

## Installation Steps

### 1. Font Installation
```bash
# Install SF Pro Display system-wide
# Install JetBrains Mono
# Install LigaSFMono Nerd Font for VS Code
./fonts/font-install.sh
```

### 2. GTK Theme Setup
```bash
# Install Gruvbox GTK theme
# Configure Papirus icons with cyan folders
./gtk/gtk-theme-install.sh
```

### 3. VS Code Configuration
- Install Ayu theme extension
- Apply settings from `vscode/settings.json`
- Install recommended extensions from `vscode/extensions.txt`

### 4. Terminal Setup
- Apply Gruvbox color scheme
- Set JetBrains Mono as default font
- Configure transparency and padding

### 5. Launcher Configuration
- Install Ulauncher Gruvbox theme
- Set SF Pro Display as launcher font
- Configure hotkeys and behavior

### 6. Dock Theming
- Apply native Gruvbox Plank theme
- Configure dock position and size
- Set auto-hide behavior

## Color Palette
- **Background**: #282828 (dark0_hard)
- **Foreground**: #ebdbb2 (light1)
- **Accent**: #8ec07c (aqua/cyan)
- **Selection**: #458588 (blue)
- **Warning**: #fabd2f (yellow)
- **Error**: #fb4934 (red)
- **Success**: #b8bb26 (green)

## Key Features
- Consistent Gruvbox color scheme across all applications
- Cyan folder accents matching Papirus theme
- Proper font rendering with ligature support
- Native window decorations with GTK integration
- Unified launcher and dock theming
- Terminal and editor harmony

## Dependencies
- Linux Mint (Cinnamon/MATE/Xfce)
- VS Code (official .deb package, not Snap)
- Ulauncher
- Plank dock
- Papirus icon theme
- Font packages (SF Pro, JetBrains Mono, LigaSFMono NF)

## Notes
- Ensure VS Code is installed via .deb package for proper GTK integration
- Restart applications after theme changes
- Some themes may require logout/login to fully apply
- Keep backup of original configurations before applying changes

## Maintenance
- Check for theme updates regularly
- Update Nerd Fonts when new versions are available
- Sync VS Code settings across devices if needed
- Test theme compatibility after system updates

---
*Last updated: September 2025*
*Compatible with: Linux Mint 21.x, VS Code 1.x*