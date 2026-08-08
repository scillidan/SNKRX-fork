# SNKRX-fork Roadmap: Adapt -> Test -> Publish

Original by [adn](https://github.com/a327ex/SNKRX) · Fork by scillidan · License: MIT

## Current Status

| Item | Value |
|------|-------|
| LÖVE version | 11.3 (Mysterious Mysteries, 2019) |
| Virtual resolution | 480x270 (16:9), canvas + float scaling |
| Input | Keyboard + Mouse + Gamepad (custom engine Input) |
| Key rebinding | None (hardcoded in main.lua), listed in TODO |
| Build targets | Windows, Linux, Linux-ARM, Web (love-js) |

---

## Phase 1: Adapt

### 1.1 LÖVE 11.3 -> 11.5 Upgrade

Minor version bump, fewer breaking changes than BYTEPATH.

- [ ] Update conf.lua: t.version = "11.5"
- [ ] Verify engine modules against 11.5 changelog
- [ ] Test canvas, shader, physics API compatibility
- [ ] Update Makefile: bundle LÖVE 11.5 runtime
- [ ] Verify web build (love-js) with 11.5

### 1.2 Screen Adaptation

Current: manual resize via options menu or K/L keys, no love.resize callback.

- [ ] Add love.resize(w, h) callback in engine/init.lua
- [ ] Automatically update sx/sy on resize
- [ ] Letterbox/pillarbox for non-16:9 (Steam Deck, ultrawide)
- [ ] HiDPI support via love.window.getDPIScale()
- [ ] Persist window size to state.txt (already partially done)

### 1.3 Key Rebinding

Current: hardcoded in main.lua lines 15-17. TODO file explicitly lists this as needed.

- [ ] Create engine/game/keybinds.lua module
- [ ] Load/save from love.filesystem.getSaveDirectory()
- [ ] Options menu UI for remapping (add to existing video options flow)
- [ ] Support per-action binding (move_left, move_right, enter)
- [ ] Gamepad button remapping
- [ ] Preset profiles (QWERTY, AZERTY, Dvorak, custom)

### 1.4 Web Build Polish

Already has love-js build script but may need updates.

- [ ] Verify love-js compatibility with LÖVE 11.5
- [ ] Test touch input on mobile browsers
- [ ] Optimize memory (currently 1GB limit in build_web.bat)
- [ ] Test clipper.lua disabled-for-web workaround

---

## Phase 2: Test

### 2.1 Test Matrix

| Platform | Variant | Priority |
|----------|---------|----------|
| Windows 10/11 | x64 fused exe | High |
| Linux X11 | Flatpak | High |
| Linux Wayland | Flatpak | High |
| Web | Chrome/Firefox | Medium |
| Steam Deck | Flatpak | Medium |

### 2.2 Smoke Test Checklist

- [ ] Launch -> Main menu -> Start run
- [ ] Full combat loop (arena -> shop -> repeat)
- [ ] Pause / Resume
- [ ] Fullscreen toggle
- [ ] Window resize (desktop)
- [ ] Gamepad connect/disconnect
- [ ] Save / Load (state.txt persistence)
- [ ] Class selection and set bonuses
- [ ] Options menu (video + sound)
- [ ] Clean exit

### 2.3 Performance Targets

| Metric | Target |
|--------|--------|
| FPS | >= 60 sustained |
| Memory | < 400 MB |
| Startup | < 3 sec |
| Bundle size | < 40 MB |

### 2.4 CI (GitHub Actions)

- [ ] Luacheck lint on push
- [ ] Build .love on tag
- [ ] Build Windows zip on tag
- [ ] Build Flatpak on tag
- [ ] Build web (love-js) on tag
- [ ] Auto GitHub Release with all artifacts

---

## Phase 3: Publish

### 3.1 Scoop (Windows)

Strategy: self-contained bucket.

1. [ ] Create GitHub repo `scoop-bucket` via BucketTemplate
2. [ ] Write manifest snkrx.json (version, url, hash, bin, shortcuts, autoupdate)
3. [ ] Users: `scoop bucket add snkrx <repo> && scoop install snkrx`

### 3.2 Flathub (Linux)

1. [ ] Prepare: manifest yml + metainfo.xml + .desktop + SVG icon
2. [ ] App ID: io.github.scillidan.snkrx
3. [ ] Manifest: build LÖVE 11.5 from source + game.love + launcher
4. [ ] Local build + lint pass
5. [ ] Fork flathub/flathub, open PR

### 3.3 Itch.io (Web)

Already partially set up (love-js build script exists).

1. [ ] Polish web build (loading screen, touch controls)
2. [ ] Upload to itch.io as HTML5
3. [ ] Enable butler for automated pushes from CI

---

## Execution Order

```
#1  LÖVE 11.3 -> 11.5 upgrade + verify
#2  Screen adaptation (love.resize + letterbox)
#3  Key rebinding system
#4  Web build polish (touch + memory)
#5  CI setup (GitHub Actions)
#6  Scoop bucket + manifest
#7  Flathub manifest + metainfo
#8  Itch.io web deployment
#9  GitHub Release automation
```
