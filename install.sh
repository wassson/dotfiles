#!/usr/bin/env bash
set -e

# Stow packages (common to all OSes)
COMMON_PACKAGES="zsh nvim helix opencode zed"

# OS detection
OS="$(uname)"
case "$OS" in
  Darwin) OS_GHOSTTY="ghostty-macos" ;;
  Linux)  OS_GHOSTTY="ghostty-linux" ;;
  *)      echo "Unsupported OS: $OS"; exit 1 ;;
esac

# Parse arguments
ADOPT=""
if [[ "$1" == "--adopt" ]]; then
  ADOPT="--adopt"
  echo "Running with --adopt: existing files will be adopted into the repo"
fi

echo "Installing dotfiles for $OS using stow..."

# Check for stow
if ! command -v stow &> /dev/null; then
  echo "Error: GNU stow is not installed."
  echo "Install it with:"
  echo "  macOS:  brew install stow"
  echo "  Debian: sudo apt install stow"
  echo "  Arch:   sudo pacman -S stow"
  exit 1
fi

# Stow common packages
for pkg in $COMMON_PACKAGES; do
  if [ -d "$pkg" ]; then
    echo "Stowing $pkg..."
    stow -v $ADOPT --target="$HOME" "$pkg"
  fi
done

# Stow OS-specific ghostty config
if [ -d "$OS_GHOSTTY" ]; then
  echo "Stowing $OS_GHOSTTY..."
  stow -v $ADOPT --target="$HOME" "$OS_GHOSTTY"
fi

# Invoke mise to install pinned versions
if command -v mise &>/dev/null; then
  echo "Running mise install..."
  mise install --yes
else
  echo "Warning: 'mise' not found. Skipping version management."
fi

echo "Dotfiles installed for $OS."
