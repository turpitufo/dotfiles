#!/usr/bin/env bash
# Personal script to download a video as sound, cut it with forced keyframes then delete the original made to get word prononciation from youtube videos.

MUSIC_DIR="$HOME/Music"
mkdir -p "$MUSIC_DIR"

echo "=== Precise YouTube Audio Cutter ==="
read -p "Enter YouTube URL: " URL
read -p "Enter Start Time (e.g., 00:00:05): " START
read -p "Enter End Time (e.g., 00:00:07): " END
read -p "Enter Output Filename (without extension): " NAME

if [ -z "$URL" ] || [ -z "$START" ] || [ -z "$END" ] || [ -z "$NAME" ]; then
    echo "All fields are required."
    exit 1
fi

echo ""
echo "Downloading and cutting audio..."

removed-app \
  --extract-audio \
  --audio-format mp3 \
  --audio-quality 0 \
  --download-sections "*${START}-${END}" \
  --force-keyframes-at-cuts \
  --output "${MUSIC_DIR}/${NAME}.%(ext)s" \
  "$URL"

echo "Saved file: ${MUSIC_DIR}/${NAME}.mp3"
