# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# Detect OS
case "$(uname)" in
  Darwin)
    # Homebrew
    [ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
    
    # macOS-specific paths
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
    export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
    
    # bun completions (macOS path)
    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
    ;;
  Linux)
    # Omarchy defaults (zsh-compatible parts only)
    # Aliases
    if command -v eza &> /dev/null; then
      alias ls='eza -lh --group-directories-first --icons=auto'
      alias lsa='ls -a'
      alias lt='eza --tree --level=2 --long --icons --git'
      alias lta='lt -a'
    fi
    alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
    if command -v zoxide &> /dev/null; then
      alias cd="zd"
      zd() {
        if [ $# -eq 0 ]; then
          builtin cd ~ && return
        elif [ -d "$1" ]; then
          builtin cd "$1"
        else
          z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
        fi
      }
    fi
    open() { xdg-open "$@" >/dev/null 2>&1 & }
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias c='opencode'
    alias d='docker'
    alias r='rails'
    n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }
    alias g='git'
    alias gcm='git commit -m'
    alias gcam='git commit -a -m'
    alias gcad='git commit -a --amend'

    # Functions
    compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
    alias decompress="tar -xzf"

    # Environment
    export SUDO_EDITOR="$EDITOR"
    export BAT_THEME=ansi

    # Tool initialization (zsh versions)
    command -v starship &> /dev/null && eval "$(starship init zsh)"
    command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"
    command -v fzf &> /dev/null && source <(fzf --zsh) 2>/dev/null
    ;;
esac

# Mise (version manager)
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
elif [ -x "$HOME/.local/bin/mise" ]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi

# Cargo/Rust
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Bun
export BUN_INSTALL="$HOME/.bun"
[ -d "$BUN_INSTALL" ] && export PATH="$BUN_INSTALL/bin:$PATH"

# Go
[ -d "$HOME/go/bin" ] && export PATH="$HOME/go/bin:$PATH"

# Ruby gems
[ -d "$HOME/.local/share/gem/ruby/3.4.0/bin" ] && export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"

# NVM (if used)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# ===== Aliases =====

# helix (Arch package uses 'helix' instead of 'hx')
alias hx="helix"

# git
alias check="git checkout"
alias checkb="git checkout -b"

# rust
alias cr="cargo run"
alias cre="cargo run --example"
alias cwr="cargo watch -x run"
cwe() { cargo watch -x "run --example $1" }

# serviceup
alias spg="docker exec -it serviceup_server psql -U postgres -d serviceup"

# odin
alias arc="odin build . -debug && ./arcane"
alias od="odin run . -collection:src=src"
oex() { odin run examples/$1 -collection:src=src }

# bun completions
[ -s "/home/aus/.bun/_bun" ] && source "/home/aus/.bun/_bun"

# monitors
brightness() { asdbctl set $1 }

# power management
alias power-status="powerprofilesctl get"
alias power-balanced="sudo powerprofilesctl set balanced"
alias power-performance="sudo powerprofilesctl set performance"
alias power-saver="sudo powerprofilesctl set power-saver"

# opencode
export PATH=/home/aus/.opencode/bin:$PATH
export PATH="$HOME/.opencode/bin:$PATH"
