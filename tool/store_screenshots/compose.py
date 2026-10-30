"""Composes App Store screenshots from raw app captures.

Usage: python3 -I tool/store_screenshots/compose.py RAW_DIR OUT_DIR [ipad|duo]
RAW_DIR holds <lang>/<shot>.png captures from capture_test.dart (made with
DEVICE=ipad or duo for those sets). Output: iPhone 6.9" 1320 x 2868, iPad
13" 2064 x 2752 or iPhone Duo unfolded 1398 x 2034.
"""

import json
import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont

KIND = sys.argv[3] if len(sys.argv) > 3 else "iphone"
# Google Play: "play" (phone, 1080 x 1920, from iPhone captures) and
# "playtab" (tablet, 1600 x 2560, from iPad captures).
IPAD = KIND in ("ipad", "playtab")
# Tablet-like frame (no Dynamic Island, small status bar) for iPad and Duo.
FLAT = KIND in ("ipad", "duo", "playtab")
# Canvas, headline size, device width, device corner radius (capture px).
W, H, HEAD, DEVICE_W, CORNER = {
    "iphone": (1320, 2868, 124, 1010, 170),
    "ipad": (2064, 2752, 150, 1640, 36),
    "duo": (1398, 2034, 100, 1120, 90),
    "play": (1080, 1920, 92, 760, 170),
    "playtab": (1600, 2560, 118, 1300, 36),
}[KIND]
BG_TOP, BG_BOTTOM = (11, 16, 32), (24, 31, 58)
LIME, BLUE, WHITE, MUTED = (184, 244, 106), (108, 147, 255), (242, 244, 250), (163, 172, 200)
SF = "/System/Library/Fonts/SFNS.ttf"
HERE = Path(__file__).parent


def font(size, weight):
    f = ImageFont.truetype(SF, size)
    # Axes: width, optical size, grade, weight.
    f.set_variation_by_axes([100, min(96, max(17, size / 3)), 400, weight])
    return f


def fit(draw, text, size, weight, max_width):
    """Largest font up to [size] that keeps [text] within [max_width]."""
    while size > 40:
        f = font(size, weight)
        if draw.textlength(text, font=f) <= max_width:
            return f
        size -= 4
    return font(size, weight)


def background():
    bg = Image.new("RGB", (W, H))
    px = ImageDraw.Draw(bg)
    for y in range(H):
        t = y / H
        px.line([(0, y), (W, y)], fill=tuple(int(a + (b - a) * t) for a, b in zip(BG_TOP, BG_BOTTOM)))
    glow = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    g = ImageDraw.Draw(glow)
    g.ellipse((-300, -350, 900, 750), fill=BLUE + (70,))
    g.ellipse((700, 1100, 1700, 2300), fill=LIME + (34,))
    glow = glow.filter(ImageFilter.GaussianBlur(220))
    bg.paste(glow, (0, 0), glow)
    return bg


def status_bar(shot):
    """Draws the time and the usual icons into the capture's top inset."""
    d = ImageDraw.Draw(shot)
    # (scale, time centre x, baseline y): iPhone inset is 62 pt at 3x,
    # iPad's 24 pt at 2x.
    k, tx, y = {"iphone": (1.0, 150, 110), "play": (1.0, 150, 110), "ipad": (0.62, 90, 34), "playtab": (0.62, 90, 34), "duo": (0.8, 110, 66)}[KIND]
    d.text((tx, y - 18 * k), "9:41", font=font(int(52 * k), 600), fill=WHITE, anchor="mm")
    x = shot.width - int(120 * k)
    s = lambda v: int(v * k)
    # Battery.
    d.rounded_rectangle((x - s(30), y - s(36), x + s(50), y), s(10), outline=WHITE, width=max(2, s(4)))
    d.rounded_rectangle((x - s(24), y - s(30), x + s(44), y - s(6)), s(6), fill=WHITE)
    d.rounded_rectangle((x + s(54), y - s(25), x + s(60), y - s(11)), 2, fill=WHITE)
    # Wi-Fi.
    cx, cy = x - s(80), y - s(2)
    for r in (s(40), s(27), s(14)):
        d.pieslice((cx - r, cy - r, cx + r, cy + r), 225, 315, fill=WHITE)
        if r > s(14):
            d.pieslice((cx - r + s(7), cy - r + s(7), cx + r - s(7), cy + r - s(7)), 225, 315, fill=(11, 16, 32))
    if FLAT:
        return
    # Signal.
    for i, h in enumerate((12, 18, 25, 32)):
        bx = x - 200 + i * 15
        d.rounded_rectangle((bx, y - h, bx + 10, y), 2, fill=WHITE)


def phone(shot, width):
    """The capture in a rounded device frame with a soft shadow."""
    scale = width / shot.width
    inner = shot.resize((width, int(shot.height * scale)), Image.LANCZOS)
    radius, bezel = int(CORNER * scale), 22 if not IPAD else 30
    mask = Image.new("L", inner.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle((0, 0) + inner.size, radius, fill=255)
    fw, fh = inner.width + 2 * bezel, inner.height + 2 * bezel
    frame = Image.new("RGBA", (fw, fh), (0, 0, 0, 0))
    fd = ImageDraw.Draw(frame)
    fd.rounded_rectangle((0, 0, fw - 1, fh - 1), radius + bezel, fill=(31, 39, 68))
    fd.rounded_rectangle((3, 3, fw - 4, fh - 4), radius + bezel - 3, outline=(64, 76, 120), width=3)
    frame.paste(inner, (bezel, bezel), mask)
    if FLAT:
        return frame
    if KIND == "play":
        # Android punch-hole camera instead of the Dynamic Island.
        r = int(16 * 3 * scale)
        cx, cy = fw // 2, bezel + int(25 * 3 * scale)
        fd.ellipse((cx - r, cy - r, cx + r, cy + r), fill=(0, 0, 0))
        return frame
    # Dynamic Island.
    iw, ih = int(126 * 3 * scale), int(37 * 3 * scale)
    ix, iy = (fw - iw) // 2, bezel + int(11 * 3 * scale)
    fd.rounded_rectangle((ix, iy, ix + iw, iy + ih), ih // 2, fill=(0, 0, 0))
    return frame


def compose(raw, lines):
    canvas = background()
    d = ImageDraw.Draw(canvas)
    first, second, sub = lines
    max_w = W - 160
    size = min(fit(d, first, HEAD, 800, max_w).size, fit(d, second, HEAD, 800, max_w).size)
    head = font(size, 800)
    top = int(HEAD * 2)  # 248 on iPhone
    d.text((W // 2, top), first, font=head, fill=WHITE, anchor="mm")
    d.text((W // 2, top + int(size * 1.12)), second, font=head, fill=LIME, anchor="mm")
    d.text((W // 2, top + int(size * 2.25)), sub, font=fit(d, sub, int(HEAD * 0.44), 500, max_w), fill=MUTED, anchor="mm")

    shot = raw.convert("RGB")
    status_bar(shot)
    device = phone(shot, DEVICE_W)
    top = top + int(size * 2.25) + int(HEAD * 0.9)
    shadow = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    ImageDraw.Draw(shadow).rounded_rectangle(
        ((W - device.width) // 2 + 10, top + 40, (W + device.width) // 2 - 10, H + 400), 160, fill=(0, 0, 0, 150)
    )
    canvas.paste(shadow.filter(ImageFilter.GaussianBlur(60)), (0, 0), shadow.filter(ImageFilter.GaussianBlur(60)))
    canvas.paste(device, ((W - device.width) // 2, top), device)
    return canvas


def main():
    raw_dir, out_dir = Path(sys.argv[1]), Path(sys.argv[2])
    captions = json.loads((HERE / "captions.json").read_text(encoding="utf-8"))
    for shot, by_lang in captions.items():
        for lang, lines in by_lang.items():
            src = raw_dir / lang / f"{shot}.png"
            dest = out_dir / lang / f"{shot}.png"
            dest.parent.mkdir(parents=True, exist_ok=True)
            compose(Image.open(src), lines).save(dest, optimize=True)
            print(dest)


if __name__ == "__main__":
    main()
