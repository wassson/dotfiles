#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_HOME="${HOME}"

COMMON_PACKAGES=(zsh nvim helix opencode zed)
ARCH_PACKAGE=arch

ADOPT=""
INSTALL_PACKAGES="false"

for arg in "$@"; do
  case "$arg" in
    --adopt)
      ADOPT="--adopt"
      ;;
    --install-packages)
      INSTALL_PACKAGES="true"
      ;;
    *)
      printf "Unknown argument: %s\n" "$arg" >&2
      printf "Usage: %s [--adopt] [--install-packages]\n" "$0" >&2
      exit 1
      ;;
  esac
done

if ! command -v stow >/dev/null 2>&1; then
  printf "stow is required. Install with: sudo pacman -S stow\n" >&2
  exit 1
fi

install_pacman_packages() {
  local pkgs=(
    hyprland hypridle hyprlock hyprsunset
    waybar walker mako swayosd
    ghostty nautilus
    jq gum wl-clipboard slurp grim satty
    gpu-screen-recorder brightnessctl upower
    playerctl pamixer rfkill bluez bluez-utils
    hyprpicker
  )

  printf "Installing core packages with pacman...\n"
  sudo pacman -S --needed --noconfirm "${pkgs[@]}"
}

stow_package() {
  local pkg="$1"
  if [[ -d "$REPO_DIR/$pkg" ]]; then
    printf "Stowing %s...\n" "$pkg"
    stow -v $ADOPT --target="$TARGET_HOME" --dir="$REPO_DIR" "$pkg"
  fi
}

cleanup_legacy_terminal_configs() {
  rm -f "$HOME/.config/alacritty/alacritty.toml"
  rm -f "$HOME/.config/kitty/kitty.conf"
  rmdir "$HOME/.config/alacritty" 2>/dev/null || true
  rmdir "$HOME/.config/kitty" 2>/dev/null || true
}

prune_omarchy_themes() {
  local theme_file="$HOME/.config/omarchy/current/theme.name"
  [[ -f "$theme_file" ]] || return 0

  local current_theme
  current_theme="$(tr -d '\n' < "$theme_file")"
  [[ -n "$current_theme" ]] || return 0

  for d in "$HOME/.config/omarchy/backgrounds"/*; do
    [[ -d "$d" ]] || continue
    [[ "$(basename "$d")" == "$current_theme" ]] || rm -rf "$d"
  done

  for d in "$HOME/.config/omarchy/themes"/*; do
    [[ -d "$d" ]] || continue
    [[ "$(basename "$d")" == "$current_theme" ]] || rm -rf "$d"
  done
}

if [[ "$INSTALL_PACKAGES" == "true" ]]; then
  install_pacman_packages
fi

for pkg in "${COMMON_PACKAGES[@]}"; do
  stow_package "$pkg"
done

if [[ "$(uname)" == "Linux" ]]; then
  stow_package ghostty-linux
elif [[ "$(uname)" == "Darwin" ]]; then
  stow_package ghostty-macos
fi

stow_package "$ARCH_PACKAGE"
prune_omarchy_themes
cleanup_legacy_terminal_configs

if command -v systemctl >/dev/null 2>&1; then
  systemctl --user daemon-reload || true
  if [[ -f "$HOME/.config/systemd/user/omarchy-battery-monitor.timer" ]]; then
    systemctl --user enable --now omarchy-battery-monitor.timer || true
  fi
fi

printf "Arch dotfiles install complete.\n"
printf "If this is a live session, restart shell and Hyprland to load new paths.\n"
