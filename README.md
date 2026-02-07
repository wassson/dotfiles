# Dotfiles

This repository contains my dotfiles for macOS and Linux.

## Setup

1. Clone this repository to your home directory or a preferred location.
2. Run `./setup.sh` to install required tools (macOS focused).
3. Run `./link.sh` to symlink dotfiles and configs.

## Arch Linux Setup

- Run `./arch-install.sh --adopt` on an existing machine to move live files under stow management.
- Run `./arch-install.sh --install-packages` on a fresh machine to install core packages and stow configs.

## Structure

- `home/common/`: Common dotfiles for all OSes.
- `home/macos/`: macOS-specific dotfiles and configs (including `.config/`).
- `home/linux/`: Linux-specific dotfiles (future).
- `bin/`: Scripts to symlink to `~/.local/bin/`.

## Tools Installed by setup.sh (macOS)

- Xcode Command Line Tools
- Homebrew
- Mise (version manager)
- Raycast (launcher)
- Helix (editor)
- Latest Rust, Node.js, Bun via Mise
