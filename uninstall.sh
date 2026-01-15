#!/usr/bin/env bash
set -e

# All packages
ALL_PACKAGES="zsh nvim helix opencode zed ghostty-common ghostty-linux ghostty-macos"

echo "Removing dotfile symlinks..."

for pkg in $ALL_PACKAGES; do
  if [ -d "$pkg" ]; then
    echo "Unstowing $pkg..."
    stow -v --target="$HOME" -D "$pkg" 2>/dev/null || true
  fi
done

echo "Dotfiles uninstalled."
