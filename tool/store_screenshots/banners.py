"""Product page header (3840 x 1646) and search results asset (1920 x 1280).

Usage: python3 -I tool/store_screenshots/banners.py RAW_DIR OUT_DIR
RAW_DIR holds the iPhone captures from capture_test.dart.
"""

import sys
from pathlib import Path

HERE = Path(__file__).parent
ROOT = HERE.parent.parent
sys.argv = sys.argv[:3]  # compose.py reads the device kind from argv.
sys.path.insert(0, str(HERE))
import compose  # noqa: E402
from compose import LIME, MUTED, WHITE, fit, font, phone, status_bar  # noqa: E402
from PIL import Image, ImageDraw, ImageFilter  # noqa: E402

ICON = ROOT / "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png"
SHOTS = ["02_pitchDeck", "01_home", "03_runway"]

TAGLINES = {
    "en": ("45 founder tools.", "One app.", "Pitch deck, runway, legal and more"),
    "tr": ("45 girişimci aracı.", "Tek uygulama.", "Yatırım sunumu, nakit, hukuk ve fazlası"),
    "fr": ("45 outils de fondateur.", "Une seule app.", "Pitch deck, trésorerie, juridique et plus"),
    "es": ("45 herramientas.", "Una sola app.", "Pitch deck, caja, legal y mucho más"),
    "de": ("45 Gründer-Tools.", "Eine App.", "Pitch Deck, Liquidität, Recht und mehr"),
}


def background(w, h):
    old = compose.W, compose.H
    compose.W, compose.H = w, h
    bg = compose.background()
    compose.W, compose.H = old
    return bg


def rounded_icon(size):
    icon = Image.open(ICON).convert("RGBA").resize((size, size), Image.LANCZOS)
    mask = Image.new("L", (size, size), 0)
    ImageDraw.Draw(mask).rounded_rectangle((0, 0, size, size), int(size * 0.225), fill=255)
    icon.putalpha(mask)
    return icon


def phones(raw_dir, lang, width):
    out = []
    for name in SHOTS:
        shot = Image.open(raw_dir / lang / f"{name}.png").convert("RGB")
        status_bar(shot)
        out.append(phone(shot, width))
    return out


def fan(canvas, devices, center_x, top, gap, angle):
    """Three devices: the middle one upright in front, the sides tilted."""
    left, mid, right = devices
    for dev, dx, rot, dy in ((left, -gap, angle, 60), (right, gap, -angle, 60)):
        r = dev.rotate(rot, resample=Image.BICUBIC, expand=True)
        canvas.paste(r, (center_x + dx - r.width // 2, top + dy), r)
    shadow = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    ImageDraw.Draw(shadow).rounded_rectangle(
        (center_x - mid.width // 2, top + 40, center_x + mid.width // 2, top + mid.height), 120, fill=(0, 0, 0, 170)
    )
    shadow = shadow.filter(ImageFilter.GaussianBlur(50))
    canvas.paste(shadow, (0, 0), shadow)
    canvas.paste(mid, (center_x - mid.width // 2, top), mid)


def text_block(canvas, x, y, lang, head_size, max_w):
    d = ImageDraw.Draw(canvas)
    first, second, sub = TAGLINES[lang]
    size = min(fit(d, first, head_size, 800, max_w).size, fit(d, second, head_size, 800, max_w).size)
    icon = rounded_icon(int(head_size * 1.25))
    canvas.paste(icon, (x, y), icon)
    name = font(int(head_size * 0.5), 700)
    d.text((x + icon.width + int(head_size * 0.3), y + icon.height // 2), "Startup Toolkit", font=name, fill=WHITE, anchor="lm")
    y += icon.height + int(head_size * 0.55)
    head = font(size, 800)
    d.text((x, y), first, font=head, fill=WHITE)
    d.text((x, y + int(size * 1.12)), second, font=head, fill=LIME)
    d.text((x, y + int(size * 2.45)), sub, font=fit(d, sub, int(head_size * 0.42), 500, max_w), fill=MUTED)


def header(raw_dir, lang):
    w, h = 3840, 1646
    canvas = background(w, h)
    fan(canvas, phones(raw_dir, lang, 760), center_x=2780, top=170, gap=620, angle=8)
    text_block(canvas, 260, 330, lang, 150, 1500)
    return canvas


def search_result(raw_dir, lang):
    w, h = 1920, 1280
    canvas = background(w, h)
    fan(canvas, phones(raw_dir, lang, 430), center_x=1500, top=170, gap=290, angle=8)
    text_block(canvas, 100, 280, lang, 88, 680)
    return canvas


def main():
    raw_dir, out_dir = Path(sys.argv[1]), Path(sys.argv[2])
    for lang in TAGLINES:
        for kind, make in (("header", header), ("search", search_result)):
            dest = out_dir / kind / f"{lang}.png"
            dest.parent.mkdir(parents=True, exist_ok=True)
            make(raw_dir, lang).convert("RGB").save(dest, optimize=True)
            print(dest)


if __name__ == "__main__":
    main()
