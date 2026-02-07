# Shim-First Omarchy Migration

This host now uses a compatibility layer in `~/.local/bin` that shadows key `omarchy-*` commands.

## What changed

- `~/.config/uwsm/env` now puts `~/.local/bin` before `~/.local/share/omarchy/bin`.
- Local shim implementations were added for high-use commands (browser/webapp launch, lock/idle, screenshot, screenrecord, waybar toggles, audio/wifi/bluetooth launchers, etc).
- Commands not migrated yet are wrapped and forwarded to upstream Omarchy scripts via `~/.local/bin/omarchy-shim-lib`.

## Why this helps

- Your current keybinds and waybar config continue to work unchanged.
- You can replace behavior command-by-command without touching all configs at once.
- When Omarchy is removed later, only fallback wrappers still pointing upstream need replacement.

## Current shim types

1. Native shim scripts (already Omarchy-independent behavior)
2. Fallback wrappers (still calling `~/.local/share/omarchy/bin/*`)

## Check status

```bash
command -v omarchy-launch-webapp
command -v omarchy-lock-screen
command -v omarchy-menu
```

Each should resolve to `~/.local/bin/...`.

## Next migration steps

1. Replace fallback wrappers with local equivalents:
   - `omarchy-menu`
   - `omarchy-menu-keybindings`
   - `omarchy-theme-bg-next`
   - `omarchy-hyprland-window-pop`
   - `omarchy-hyprland-window-close-all`
   - `omarchy-hyprland-workspace-toggle-gaps`
2. Move theme ownership from `~/.config/omarchy/current/*` to a new local theme tree.
3. Copy Omarchy default Hypr files from `~/.local/share/omarchy/default/hypr/*` into `~/.config/hypr/defaults/*` and repoint `~/.config/hypr/hyprland.conf` sources.
4. Replace Omarchy-specific waybar commands in `~/.config/waybar/config.jsonc` with your own command names.

## Rollback

If needed, restore original precedence in `~/.config/uwsm/env`:

```bash
export PATH=$OMARCHY_PATH/bin:$PATH
```
