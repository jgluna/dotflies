# GRUB Theme - HiDPI Custom Theme

A clean, modern GRUB bootloader theme optimized for HiDPI displays (3840x2160).

## Features

- Dark background (#1E1E2E - Catppuccin Mocha base color)
- Centered menu box with clear contrast
- Large, readable fonts optimized for 4K displays
- Clean, minimalist design
- Custom colored menu highlights

## Color Scheme

- Background: `#1E1E2E` (Dark purple-grey)
- Text: `#CDD6F4` (Light grey-blue)
- Selected item: `#89B4FA` (Bright blue)
- Menu box: `#313244` (Slightly lighter grey)
- Borders: `#45475A` (Medium grey)

## Installation

### Automatic Installation (Recommended)

Run the installation script with sudo:

```bash
cd /home/juan-luna/dotfiles/grub-theme-custom
sudo ./install.sh
```

The script will:
1. Create the theme directory in `/boot/grub/themes/`
2. Copy all theme files
3. Backup your current GRUB configuration
4. Update GRUB to use the new theme
5. Set the display resolution to 3840x2160

After installation, reboot to see your new theme.

### Manual Installation

If you prefer to install manually:

1. Copy the theme files:
   ```bash
   sudo mkdir -p /boot/grub/themes/grub-theme-custom
   sudo cp *.png *.pf2 theme.txt /boot/grub/themes/grub-theme-custom/
   ```

2. Edit `/etc/default/grub` and add or modify these lines:
   ```bash
   GRUB_THEME="/boot/grub/themes/grub-theme-custom/theme.txt"
   GRUB_GFXMODE=3840x2160
   ```

3. Update GRUB:
   ```bash
   sudo update-grub
   # or on some systems:
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   ```

4. Reboot

## File Structure

```
grub-theme-custom/
├── theme.txt              # Main theme configuration
├── dejavu_sans_*.pf2      # Font files for various sizes
├── menu_*.png            # Menu box border/background images
├── select_*.png          # Selected item highlight images
├── generate_images.py    # Script to regenerate PNG images
├── install.sh            # Automatic installation script
└── README.md             # This file
```

## Customization

### Changing Colors

Edit `theme.txt` and modify the color values:

- `desktop-color`: Main background
- `item_color`: Menu text color
- `selected_item_color`: Selected item text color

Then regenerate the PNG images:

```bash
python3 generate_images.py
```

Edit the color values in `generate_images.py` to match your theme.

### Adjusting Menu Size/Position

In `theme.txt`, modify the boot_menu section:

```
+ boot_menu {
    left = 25%      # Distance from left edge
    width = 50%     # Width of menu box
    top = 30%       # Distance from top
    height = 40%    # Height of menu box
    ...
}
```

### Font Sizes

To create different font sizes:

```bash
grub-mkfont -s <SIZE> -o output.pf2 /usr/share/fonts/truetype/dejavu/DejaVuSans.ttf
```

Then update the font references in `theme.txt`.

### Different Resolutions

For different display resolutions, adjust:

1. Font sizes (larger for higher DPI, smaller for lower)
2. `item_height` and `item_spacing` in theme.txt
3. `GRUB_GFXMODE` in `/etc/default/grub`

Recommended font sizes by resolution:
- 1920x1080: 18-24pt fonts
- 2560x1440: 24-32pt fonts
- 3840x2160: 32-48pt fonts (current configuration)

## Troubleshooting

### Theme doesn't appear after reboot

1. Verify the theme is installed:
   ```bash
   ls -la /boot/grub/themes/grub-theme-custom/
   ```

2. Check GRUB configuration:
   ```bash
   grep GRUB_THEME /etc/default/grub
   ```

3. Regenerate GRUB config:
   ```bash
   sudo update-grub
   ```

### Text is too small/large

Adjust the font sizes in `theme.txt` and regenerate fonts with different sizes using `grub-mkfont`.

### Colors look wrong

Make sure your display is in the correct color mode. GRUB may have limited color depth depending on your graphics hardware.

### Menu is off-center

Adjust the `left`, `top`, `width`, and `height` values in the `boot_menu` section of `theme.txt`.

## Uninstallation

To remove the theme and restore defaults:

1. Edit `/etc/default/grub` and remove or comment out:
   ```
   #GRUB_THEME="/boot/grub/themes/grub-theme-custom/theme.txt"
   ```

2. Update GRUB:
   ```bash
   sudo update-grub
   ```

3. Optionally, remove the theme files:
   ```bash
   sudo rm -rf /boot/grub/themes/grub-theme-custom
   ```

## Credits

- Color scheme inspired by Catppuccin Mocha theme
- Fonts: DejaVu Sans family
- Created with pure Python (no external image dependencies)

## License

Free to use and modify.
