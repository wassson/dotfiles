#!/usr/bin/env bash
set -e

echo "Setting up dotfiles for macOS..."

# Install Xcode Command Line Tools
if xcode-select -p >/dev/null 2>&1; then
    echo "Xcode Command Line Tools already installed: $(xcode-select -p)"
else
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Please complete the Xcode installation and run this script again."
    exit 1
fi

# Install Homebrew
if command -v brew >/dev/null 2>&1; then
    echo "Homebrew already installed: $(brew --version | head -1)"
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"  # For Apple Silicon
fi

# Install Mise
if command -v mise >/dev/null 2>&1; then
    echo "Mise already installed: $(mise --version)"
else
    echo "Installing Mise..."
    brew install mise
fi

# Install Raycast
if [ -d "/Applications/Raycast.app" ]; then
    echo "Raycast already installed at /Applications/Raycast.app"
elif brew list --cask raycast >/dev/null 2>&1; then
    echo "Raycast already installed via Homebrew"
else
    echo "Installing Raycast..."
    brew install --cask raycast
fi

# Install Helix
if command -v helix >/dev/null 2>&1; then
    echo "Helix already installed: $(helix --version)"
elif brew list helix >/dev/null 2>&1; then
    echo "Helix already installed via Homebrew"
else
    echo "Installing Helix..."
    brew install helix
fi

# Install Neovim
if command -v nvim >/dev/null 2>&1; then
    echo "Neovim already installed: $(nvim --version | head -1)"
elif brew list neovim >/dev/null 2>&1; then
    echo "Neovim already installed via Homebrew"
else
    echo "Installing Neovim..."
    brew install neovim
fi

# Install tools with Mise
echo "Installing latest Rust, Node, and Bun with Mise..."
mise install

echo "✅ Setup complete!"