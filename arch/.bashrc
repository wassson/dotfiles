# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# Baseline aliases and functions vendored in dotfiles
source ~/.config/arch-default/bash/rc

# Local command shims should win during Omarchy migration
export PATH="$HOME/.local/bin:$PATH"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
. "$HOME/.cargo/env"
