#!/bin/sh
# Records the App Store previews (videos) for every language and converts
# them to Apple's specs: H.264, 30 fps, 15-30 s, with a silent AAC track.
#
#   tool/store_screenshots/previews.sh SIMULATOR_ID OUT_DIR [WxH] [langs]
#
# WxH is the preview size: 886x1920 for iPhone (and iPhone Duo) from an
# iPhone 11 Pro Max simulator, 1200x1600 for iPad from an iPad Pro 13".
set -eu

SCH="$(dirname "$0")/../../ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme"
if [ -f "$SCH" ]; then
  restore_scheme() {
    git checkout -- "$SCH" 2>/dev/null || true
  }
  trap restore_scheme EXIT INT TERM
  sed -i '' -e 's/buildConfiguration = "Release"/buildConfiguration = "Debug"/' "$SCH"
fi

SIM=$1
OUT=$2
SIZE=${3:-886x1920}
LANGS=${4:-"en tr fr es de"}
W=${SIZE%x*}
H=${SIZE#*x}
mkdir -p "$OUT/raw"
# simctl's recorder fails (SimRenderServer error 2) on relative paths.
OUT=$(cd "$OUT" && pwd)

xcrun simctl boot "$SIM" 2>/dev/null || true
xcrun simctl status_bar "$SIM" override --time 9:41 --batteryState charged \
  --batteryLevel 100 --cellularBars 4 --wifiBars 3 --dataNetwork wifi

for lang in $LANGS; do
  echo "==> Recording App Preview for: $lang"
  # Right after a run flutter sometimes doesn't list the simulator yet.
  for _ in 1 2 3 4 5 6 7 8; do
    flutter devices 2>/dev/null | grep -q "$SIM" && break
    sleep 3
  done
  raw="$OUT/raw/$lang.mp4"
  xcrun simctl io "$SIM" recordVideo --codec=h264 --force "$raw" &
  rec=$!
  sleep 2
  flutter test integration_test/app_preview_test.dart -d "$SIM" --timeout 5m \
    --dart-define=LANG="$lang" || echo "tour failed for $lang" >&2
  # SIGINT makes simctl finish the file properly.
  kill -INT $rec 2>/dev/null || true
  wait $rec 2>/dev/null || true
  sleep 2

  if [ ! -s "$raw" ]; then
    echo "Raw video not recorded for $lang" >&2
    continue
  fi

  # The tour starts with a black screen; start at the first lit frame.
  start=$(ffmpeg -hide_banner -i "$raw" -vf "blackdetect=d=3:pix_th=0.02" \
    -an -f null - 2>&1 | sed -n 's/.*black_end:\([0-9.]*\).*/\1/p' | head -1)

  ffmpeg -hide_banner -loglevel error -y -ss "${start:-0}" -i "$raw" \
    -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 \
    -t 29.5 -map 0:v -map 1:a \
    -vf "fps=30,scale=$W:$H:force_original_aspect_ratio=increase,crop=$W:$H,setsar=1" \
    -c:v libx264 -profile:v high -level 4.0 -pix_fmt yuv420p -b:v 10M \
    -c:a aac -b:a 128k -shortest -movflags +faststart \
    "$OUT/$lang.mp4"
  echo "Saved: $OUT/$lang.mp4"
done

