#!/bin/sh

set -e

THEME_NAME=$(cat "$HOME/.config/omarchy/current/theme.name" 2>/dev/null)
if [ -z "$THEME_NAME" ]; then
  echo "Could not determine current theme"
  exit 1
fi

BACKGROUNDS_DIR="$HOME/.config/omarchy/backgrounds/$THEME_NAME"
WALLPAPERS="car.jpeg knight.jpeg river.jpeg"

mkdir -p "$BACKGROUNDS_DIR"

for WALLPAPER in $WALLPAPERS; do
  WALLPAPER_SOURCE="$HOME/media/wallpaper/$WALLPAPER"
  WALLPAPER_DEST="$BACKGROUNDS_DIR/$WALLPAPER"

  if [ ! -f "$WALLPAPER_SOURCE" ]; then
    echo "Wallpaper not found at $WALLPAPER_SOURCE"
    continue
  fi

  if [ -e "$WALLPAPER_DEST" ]; then
    echo "Wallpaper already exists at $WALLPAPER_DEST"
  else
    ln -s "$WALLPAPER_SOURCE" "$WALLPAPER_DEST"
    echo "Linked wallpaper to $WALLPAPER_DEST"
  fi
done

echo "Wallpaper override setup complete for theme: $THEME_NAME"
echo "Run 'omarchy-theme-bg-next' to cycle to the new wallpaper"
