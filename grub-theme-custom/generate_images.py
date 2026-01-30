#!/usr/bin/env python3
"""Generate PNG images for GRUB theme without external dependencies."""

import struct
import zlib

def create_png(width, height, r, g, b, a=255):
    """Create a PNG image with a solid color."""

    def write_chunk(chunk_type, data):
        """Write a PNG chunk."""
        chunk = chunk_type + data
        crc = zlib.crc32(chunk) & 0xffffffff
        return struct.pack('>I', len(data)) + chunk + struct.pack('>I', crc)

    # PNG signature
    png_data = b'\x89PNG\r\n\x1a\n'

    # IHDR chunk
    ihdr = struct.pack('>IIBBBBB', width, height, 8, 6, 0, 0, 0)
    png_data += write_chunk(b'IHDR', ihdr)

    # IDAT chunk - image data
    raw_data = bytearray()
    for y in range(height):
        raw_data.append(0)  # Filter type
        for x in range(width):
            raw_data.extend([r, g, b, a])

    compressed = zlib.compress(bytes(raw_data), 9)
    png_data += write_chunk(b'IDAT', compressed)

    # IEND chunk
    png_data += write_chunk(b'IEND', b'')

    return png_data

def hex_to_rgb(hex_color):
    """Convert hex color to RGB tuple."""
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

# Create images
print("Generating GRUB theme images...")

# Menu box background - slightly lighter than main background
menu_bg = hex_to_rgb("#313244")  # Darker box
menu_c = create_png(1, 1, *menu_bg, 240)
with open("menu_c.png", "wb") as f:
    f.write(menu_c)

# Create bordered menu pieces
menu_border = hex_to_rgb("#45475A")
menu_nw = create_png(8, 8, *menu_border, 255)
menu_ne = create_png(8, 8, *menu_border, 255)
menu_sw = create_png(8, 8, *menu_border, 255)
menu_se = create_png(8, 8, *menu_border, 255)
menu_n = create_png(1, 8, *menu_border, 255)
menu_s = create_png(1, 8, *menu_border, 255)
menu_w = create_png(8, 1, *menu_border, 255)
menu_e = create_png(8, 1, *menu_border, 255)

with open("menu_nw.png", "wb") as f: f.write(menu_nw)
with open("menu_ne.png", "wb") as f: f.write(menu_ne)
with open("menu_sw.png", "wb") as f: f.write(menu_sw)
with open("menu_se.png", "wb") as f: f.write(menu_se)
with open("menu_n.png", "wb") as f: f.write(menu_n)
with open("menu_s.png", "wb") as f: f.write(menu_s)
with open("menu_w.png", "wb") as f: f.write(menu_w)
with open("menu_e.png", "wb") as f: f.write(menu_e)

# Selected item background - highlight color
select_bg = hex_to_rgb("#89B4FA")
select_c = create_png(1, 1, *select_bg, 80)  # Semi-transparent blue
with open("select_c.png", "wb") as f:
    f.write(select_c)

# Create bordered selected pieces
select_nw = create_png(8, 8, *select_bg, 200)
select_ne = create_png(8, 8, *select_bg, 200)
select_sw = create_png(8, 8, *select_bg, 200)
select_se = create_png(8, 8, *select_bg, 200)
select_n = create_png(1, 8, *select_bg, 200)
select_s = create_png(1, 8, *select_bg, 200)
select_w = create_png(8, 1, *select_bg, 200)
select_e = create_png(8, 1, *select_bg, 200)

with open("select_nw.png", "wb") as f: f.write(select_nw)
with open("select_ne.png", "wb") as f: f.write(select_ne)
with open("select_sw.png", "wb") as f: f.write(select_sw)
with open("select_se.png", "wb") as f: f.write(select_se)
with open("select_n.png", "wb") as f: f.write(select_n)
with open("select_s.png", "wb") as f: f.write(select_s)
with open("select_w.png", "wb") as f: f.write(select_w)
with open("select_e.png", "wb") as f: f.write(select_e)

print("Images generated successfully!")
print("Files created:")
print("  - menu_*.png (9 files)")
print("  - select_*.png (9 files)")
