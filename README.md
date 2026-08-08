# SNKRX-fork

Original by [adn](https://github.com/a327ex/SNKRX) · Fork by scillidan · License: MIT

A rogue-lite auto shooter where you control a snake of heroes.

## Requirements

- **LÖVE 11.5** (Mysterious Mysteries, 2023)

## Running

```bash
engine/love/love.exe --console .
```

## Building

```bash
make
```

Outputs to `dist/` directory.

## Changes from upstream

- Upgraded from LÖVE 11.3 to 11.5
- Added dynamic screen resizing with `love.resize` callback
- Added key rebinding system (`settings.lua` with persistent save)
- Added GitHub Actions CI (lint, build, release)
- Added Flathub/Scoop packaging manifests

## Controls

| Action | Keyboard | Gamepad |
|--------|----------|---------|
| Move left | A / Left / Left click | D-pad left |
| Move right | D/E/S / Right / Right click | D-pad right |
| Confirm | Space / Enter | A/B/X |

Key bindings can be customized and are saved automatically.
