"""Generates the Startup Toolkits app icon and writes every platform size.

Design (master plan §7.1 tokens): midnight background with a soft blue
glow, a lime progress ring (the Home "Launch path") with its current-step
dot, and a 2x2 toolkit grid with one lime tile.

Run from the project root:  python3 -I tool/icon/generate_icon.py
Needs Pillow. Outputs:
  assets/icon/icon-1024.png              master, RGB (App Store: no alpha)
  ios/Runner/Assets.xcassets/AppIcon.appiconset/*.png
  android/app/src/main/res/mipmap-*/ic_launcher.png          legacy
  android/app/src/main/res/mipmap-*/ic_launcher_foreground.png adaptive
  android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml
"""

import json
import math
import os

from PIL import Image, ImageDraw, ImageFilter

BG = (11, 16, 32)          # bg #0B1020
SURFACE = (31, 39, 68)     # surface-2 #1F2744
BORDER = (42, 51, 85)      # border #2A3355
LIME = (184, 244, 106)     # accent #B8F46A
BLUE = (108, 147, 255)     # blue #6C93FF

SS = 4                     # supersampling for smooth edges
SIZE = 1024


def draw_mark(draw, cx, cy, scale):
    """Ring, current-step dot and toolkit grid, centred on (cx, cy)."""
    r = 300 * scale
    w = 64 * scale
    box = [cx - r, cy - r, cx + r, cy + r]
    draw.arc(box, 0, 360, fill=BORDER, width=int(w))
    # Progress from 12 o'clock, clockwise, about 70%.
    start, end = -90, -90 + 252
    draw.arc(box, start, end, fill=LIME, width=int(w))
    for angle in (start, end):  # round caps
        a = math.radians(angle)
        px, py = cx + (r - w / 2) * math.cos(a), cy + (r - w / 2) * math.sin(a)
        draw.ellipse([px - w / 2, py - w / 2, px + w / 2, py + w / 2], fill=LIME)
    # Current-step dot at the end of the arc, with a dark halo.
    a = math.radians(end)
    px, py = cx + (r - w / 2) * math.cos(a), cy + (r - w / 2) * math.sin(a)
    halo, dot = 58 * scale, 38 * scale
    draw.ellipse([px - halo, py - halo, px + halo, py + halo], fill=BG)
    draw.ellipse([px - dot, py - dot, px + dot, py + dot], fill=LIME)

    # 2x2 toolkit grid.
    tile, gap, radius = 118 * scale, 30 * scale, 30 * scale
    origin = cx - tile - gap / 2, cy - tile - gap / 2
    for row in range(2):
        for col in range(2):
            x = origin[0] + col * (tile + gap)
            y = origin[1] + row * (tile + gap)
            lime = row == 0 and col == 1
            draw.rounded_rectangle(
                [x, y, x + tile, y + tile],
                radius=radius,
                fill=LIME if lime else SURFACE,
                outline=None if lime else BORDER,
                width=int(6 * scale),
            )


def background(size):
    img = Image.new("RGB", (size, size), BG)
    glow = Image.new("RGB", (size, size), BG)
    g = ImageDraw.Draw(glow)
    r = size * 0.55
    g.ellipse([-r * 0.35, -r * 0.35, r * 1.2, r * 1.2], fill=(36, 52, 110))
    glow = glow.filter(ImageFilter.GaussianBlur(size * 0.18))
    return Image.blend(img, glow, 0.85)


def master():
    big = SIZE * SS
    img = background(big)
    draw_mark(ImageDraw.Draw(img), big / 2, big / 2, SS)
    return img.resize((SIZE, SIZE), Image.LANCZOS)


def adaptive_foreground(px):
    """Transparent 108dp layer; the mark fits the 66dp safe zone."""
    big = px * SS
    img = Image.new("RGBA", (big, big), (0, 0, 0, 0))
    # The 1024 mark spans ~728 px; scale it to ~60/108 of the layer.
    scale = (big * 60 / 108) / 728
    draw_mark(ImageDraw.Draw(img), big / 2, big / 2, scale)
    return img.resize((px, px), Image.LANCZOS)


def main():
    icon = master()
    os.makedirs("assets/icon", exist_ok=True)
    icon.save("assets/icon/icon-1024.png")

    # iOS: every size listed in the asset catalog, RGB without alpha.
    ios_dir = "ios/Runner/Assets.xcassets/AppIcon.appiconset"
    with open(os.path.join(ios_dir, "Contents.json")) as f:
        images = json.load(f)["images"]
    for entry in images:
        name = entry.get("filename")
        if not name:
            continue
        points = float(entry["size"].split("x")[0])
        scale = int(entry["scale"].rstrip("x"))
        px = round(points * scale)
        icon.resize((px, px), Image.LANCZOS).save(os.path.join(ios_dir, name))

    # Android legacy and adaptive icons.
    res = "android/app/src/main/res"
    densities = {"mdpi": 1, "hdpi": 1.5, "xhdpi": 2, "xxhdpi": 3, "xxxhdpi": 4}
    for density, factor in densities.items():
        folder = os.path.join(res, f"mipmap-{density}")
        os.makedirs(folder, exist_ok=True)
        icon.resize((round(48 * factor),) * 2, Image.LANCZOS).save(
            os.path.join(folder, "ic_launcher.png")
        )
        adaptive_foreground(round(108 * factor)).save(
            os.path.join(folder, "ic_launcher_foreground.png")
        )
    anydpi = os.path.join(res, "mipmap-anydpi-v26")
    os.makedirs(anydpi, exist_ok=True)
    with open(os.path.join(anydpi, "ic_launcher.xml"), "w") as f:
        f.write(
            '<?xml version="1.0" encoding="utf-8"?>\n'
            '<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">\n'
            '    <background android:drawable="@color/ic_launcher_background"/>\n'
            '    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>\n'
            '    <monochrome android:drawable="@mipmap/ic_launcher_foreground"/>\n'
            "</adaptive-icon>\n"
        )
    values = os.path.join(res, "values")
    os.makedirs(values, exist_ok=True)
    with open(os.path.join(values, "ic_launcher_background.xml"), "w") as f:
        f.write(
            '<?xml version="1.0" encoding="utf-8"?>\n<resources>\n'
            '    <color name="ic_launcher_background">#0B1020</color>\n'
            "</resources>\n"
        )
    print("Icons written.")


if __name__ == "__main__":
    main()
