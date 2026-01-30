#!/bin/bash

# GRUB Theme Installer
# This script installs the custom GRUB theme optimized for HiDPI displays

set -e

THEME_NAME="grub-theme-custom"
THEME_DIR="/boot/grub/themes/$THEME_NAME"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing GRUB Theme: $THEME_NAME"
echo "=================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)"
    exit 1
fi

# Create themes directory if it doesn't exist
echo "[1/4] Creating theme directory..."
mkdir -p "$THEME_DIR"

# Copy theme files
echo "[2/4] Copying theme files..."
cp -r "$SCRIPT_DIR"/*.png "$THEME_DIR/"
cp -r "$SCRIPT_DIR"/*.pf2 "$THEME_DIR/"
cp "$SCRIPT_DIR/theme.txt" "$THEME_DIR/"

echo "      Copied $(ls -1 "$SCRIPT_DIR"/*.png 2>/dev/null | wc -l) PNG files"
echo "      Copied $(ls -1 "$SCRIPT_DIR"/*.pf2 2>/dev/null | wc -l) font files"

# Update GRUB configuration
echo "[3/4] Updating GRUB configuration..."

GRUB_CONFIG="/etc/default/grub"
BACKUP_CONFIG="${GRUB_CONFIG}.backup.$(date +%Y%m%d_%H%M%S)"

# Backup existing config
cp "$GRUB_CONFIG" "$BACKUP_CONFIG"
echo "      Backed up existing config to: $BACKUP_CONFIG"

# Remove existing GRUB_THEME line if present
sed -i '/^GRUB_THEME=/d' "$GRUB_CONFIG"

# Add new theme line
echo "GRUB_THEME=\"$THEME_DIR/theme.txt\"" >> "$GRUB_CONFIG"

# Optional: Set GRUB resolution for HiDPI
if ! grep -q "^GRUB_GFXMODE=" "$GRUB_CONFIG"; then
    echo "GRUB_GFXMODE=3840x2160" >> "$GRUB_CONFIG"
    echo "      Set GRUB resolution to 3840x2160"
fi

# Update GRUB
echo "[4/4] Updating GRUB bootloader..."
if command -v update-grub &> /dev/null; then
    update-grub
elif command -v grub-mkconfig &> /dev/null; then
    grub-mkconfig -o /boot/grub/grub.cfg
else
    echo "Error: Could not find update-grub or grub-mkconfig"
    exit 1
fi

echo ""
echo "=================================="
echo "Installation complete!"
echo ""
echo "The theme has been installed to: $THEME_DIR"
echo "Your original GRUB config was backed up to: $BACKUP_CONFIG"
echo ""
echo "Reboot your system to see the new GRUB theme."
echo ""
