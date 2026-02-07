#!/bin/sh

# Rust: rustup manages the toolchain, rust-analyzer is the LSP
yay -S --noconfirm --needed rustup rust-analyzer
rustup default stable

# Odin: odin compiler + OLS language server
yay -S --noconfirm --needed odin odinls-bin

# Ruby: ruby + ruby-lsp language server
yay -S --noconfirm --needed ruby ruby-lsp
