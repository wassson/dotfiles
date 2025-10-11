#!/usr/bin/env bash
set -e

# OS detection
OS="$(uname)"
case "$OS" in
  Darwin) OS_DIR="macos" ;;
  Linux)  OS_DIR="linux"  ;;
  *)      echo "Unsupported OS: $OS"; exit 1 ;;
esac

echo "Symlinking dotfiles for $OS..."

# Include dotfiles in globs
shopt -s dotglob

# Symlink helper
link(){
  mkdir -p "$(dirname "$2")"
  ln -sfv "$PWD/$1" "$2"
}

# Symlink common & OS-specific dotfiles
for f in home/common/*; do
  if [ -f "$f" ] && [[ "$(basename "$f")" != ".DS_Store" ]]; then
    link "$f" "$HOME/$(basename "$f")"
  fi
done
for f in home/$OS_DIR/*; do
  if [ -f "$f" ] && [[ "$(basename "$f")" != ".DS_Store" ]]; then
    link "$f" "$HOME/$(basename "$f")"
  fi
done

# Symlink .config files
if [ -d "home/common/.config" ]; then
  for f in home/common/.config/*; do
    if [ -e "$f" ] && [[ "$(basename "$f")" != ".DS_Store" ]]; then
      link "$f" "$HOME/.config/$(basename "$f")"
    fi
  done
fi
if [ -d "home/$OS_DIR/.config" ]; then
  for f in home/$OS_DIR/.config/*; do
    if [ -e "$f" ] && [[ "$(basename "$f")" != ".DS_Store" ]]; then
      link "$f" "$HOME/.config/$(basename "$f")"
    fi
  done
fi

# Symlink bin scripts
mkdir -p "$HOME/.local/bin"
for s in bin/*; do
  if [ -e "$s" ]; then
    link "$s" "$HOME/.local/bin/$(basename "$s")"
  fi
done

# Invoke mise to install pinned versions
if command -v mise >/dev/null; then
  echo "Running mise install..."
  mise install --yes
else
  echo "⚠️  'mise' not found. Skipping version management."
fi

echo "✅ Dotfiles symlinked for $OS."