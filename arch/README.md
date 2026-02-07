# Arch Package

This stow package contains Linux desktop/session config and Omarchy-compatibility shims.

## Includes

- `~/.config/hypr`, `~/.config/waybar`, `~/.config/walker`, `~/.config/uwsm`
- `~/.config/omarchy` (current theme/background state used by active configs)
- `~/.config/swayosd` (runtime terminal defaults to Ghostty)
- `~/.config/systemd/user/omarchy-battery-monitor.*`
- `~/.local/bin/omarchy-*` shim/wrapper commands
- `~/.bashrc`, `~/.XCompose`

## Install

From repo root:

```bash
./arch-install.sh --adopt
```

For a fresh Arch install (and package bootstrap):

```bash
./arch-install.sh --install-packages
```
