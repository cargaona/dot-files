# Dotfiles Review & Improvement Roadmap

**Overall Assessment:** Solid 7.5/10 — Mature, battle-tested setup with impressive infrastructure work, but some consistency and documentation improvements needed.

---

## Critical Issues (Fix First)

### 1. **Bug: `ohMyZsh.custom` Path Error**
- **File:** `nix/packages/common.nix` (line ~)
- **Issue:** Sets `ohMyZsh.custom = "/Users/char/.zshrc"` when `isSFF` is true
- **Problem:** `sff` is the Linux desktop, not macOS. This should be the Linux zshrc path.
- **Fix:** Change to conditional path based on platform, not hostname
- **Priority:** HIGH (active bug affecting zsh theme loading)

### 2. **Syncthing Placeholder Device ID**
- **File:** `nix/modules/network/sync.nix`
- **Issue:** Device ID for "sff" is `"DEVICE-ID-GOES-HERE"`
- **Problem:** Syncthing sync likely non-functional between sff and other devices
- **Fix:** Fill in actual device ID or document how to generate it
- **Priority:** HIGH (breaks core sync functionality)

### 3. **Duplicate Home Manager Config**
- **Files:** `nix/users/home.nix` (90 lines) and `nix/home/home.nix` (580+ lines)
- **Issue:** Nearly identical configs; `users/` version is older, missing cross-platform support and caelestia integration
- **Problem:** Maintenance burden, potential config drift
- **Fix:** Remove `nix/users/home.nix` entirely
- **Priority:** HIGH (architectural cleanup)

---

## Consistency Issues (Fix Second)

### 4. **Channel Imports Breaking Flake Purity**
- **Files:**
  - `nix/modules/desktop/fonts.nix` — uses `import <nixos-unstable>`
  - `nix/modules/desktop/cosmic.nix` — uses `import <nixos-unstable>`
  - `nix/hosts/server/configuration.nix` — uses `<home-manager/nixos>` channel import
- **Problem:** Breaks reproducibility, inconsistent with desktop's flake-based approach
- **Fix:** Use the `unstable` specialArg from `flake.nix` (already done in `flake.nix` lines 49-52)
- **Priority:** MEDIUM (affects reproducibility)

### 5. **Environment Variables Defined in 3 Places**
- **Files:**
  - `nix/modules/desktop/hyprland.nix` — Nix module defines WAYLAND/NVIDIA vars
  - `nix/modules/desktop/cosmic.nix` — defines `environment.variables`
  - `hypr/hyprland/hyprland.conf` + `hypr/hyprland/env.conf` — defines same vars in Hyprland syntax
- **Problem:** Triplication creates maintenance burden; changes need to be synced in 3 places
- **Fix:** Single source of truth (recommend Nix module), propagate to Hyprland via `environment.variables`
- **Priority:** MEDIUM (maintenance burden, not breaking)

### 6. **Monolithic Package List**
- **File:** `nix/packages/common.nix` (140+ packages in one flat list)
- **Issue:** No categorization beyond `desktopPackages` and `commonPackages`
- **Problem:** Hard to navigate, understand, and maintain
- **Fix:** Split into:
  - `packages/dev.nix` (LSP, build tools, runtimes)
  - `packages/desktop.nix` (GUI apps, media, utils)
  - `packages/infrastructure.nix` (k3s, docker, ollama)
  - `packages/cli.nix` (shells, terminal tools)
  - `packages/common.nix` (aggregates all of the above)
- **Priority:** MEDIUM (improves readability, no functional change)

### 7. **Fragile Hostname-Based Config Gating**
- **File:** `nix/packages/common.nix` (line: `isSFF = config.networking.hostName == "sff"`)
- **Issue:** Uses string comparison to gate desktop-only packages instead of proper NixOS options
- **Problem:** Doesn't scale; difficult to add new hosts without modifying common.nix
- **Fix:** Adopt the `kindle.nix` pattern with `options.host.isDesktop` and `mkEnableOption`, define in each host's `configuration.nix`
- **Priority:** MEDIUM (not urgent, but improves architecture)

---

## Module Architecture Issues

### 8. **Inconsistent NixOS Module Pattern**
- **Current State:**
  - `kindle.nix` — ✅ Proper `options` interface with `mkEnableOption`, `mkOption`, `mkIf`
  - `ollama.nix`, `k3s.nix`, `docker.nix`, `immich.nix` — ❌ Direct config, no options interface
- **Problem:** Can't customize modules per-host without duplicating imports
- **Fix:** Convert to options pattern:
  ```nix
  options.services.ollama = {
    enable = mkEnableOption "Ollama LLM inference";
    device = mkOption { type = types.str; default = "cuda"; };
    ...
  };
  config = mkIf cfg.enable { ... };
  ```
- **Priority:** LOW (architectural; can be done incrementally)

### 9. **`gtk.nix` Entirely Commented Out**
- **File:** `nix/modules/desktop/gtk.nix`
- **Issue:** Every option is commented except `dconf.settings`
- **Problem:** Dead code; unclear if intentional or incomplete
- **Fix:** Either populate with GTK theming (Catppuccin? matching Hyprland) or remove file
- **Priority:** LOW (cosmetic)

---

## Code Quality Issues

### 10. **Neovim Backup File Explosion**
- **Location:** `nvim/lua/autocommands/` contains ~32 files named `yaml.lua.backup.backup.backup...` (up to 32 levels deep)
- **Problem:** Runaway backup script; `.gitignore` has `*.backup` but files still present
- **Fix:** 
  ```bash
  cd nvim/lua/autocommands/
  rm -f yaml.lua.backup*
  ```
- **Priority:** LOW (cosmetic, not affecting functionality)

### 11. **Hardcoded Absolute Paths**
- **Locations:**
  - `nix/home/home.nix` line 31: `sessionPath = "/home/char/..."`
  - `zsh/.zshrc`: theme path hardcoded to `/home/char`
  - `nix/home/caelestia-config.nix`: wallpaper path has `/home/char`
- **Problem:** Not portable; need to update multiple places for different users
- **Fix:** Use `config.home.homeDirectory` in nix files; use `~` in shell scripts
- **Priority:** LOW (only matters if sharing with others)

---

## Documentation Issues

### 12. **Empty Root README**
- **File:** `readme.md` (root level, 0 lines)
- **Issue:** No high-level documentation
- **Problem:** New users/contributors have no entry point
- **Fix:** Add:
  - Quick overview (what this repo does)
  - System architecture (nix flake + dotfiles hybrid approach)
  - Quick start (clone, nixos-rebuild switch, home-manager switch)
  - Module guide (where to find things)
- **Priority:** LOW (nice-to-have for collaboration)

### 13. **Newsboat Plaintext Credentials**
- **File:** `newsboat/config` (lines with `fever-login` and `fever-password`)
- **Issue:** Placeholder values, but pattern suggests real credentials could be here
- **Problem:** Security risk if accidentally committed
- **Fix:** Use `sops-nix` or `agenix` for secrets management
- **Priority:** LOW (if passwords are actually blank/placeholder)

---

## Positive Findings (Don't Change)

- ✅ **Hyprland config modularity** — 10 focused `source`'d files is excellent
- ✅ **`kindle.nix` exemplary module** — proper options pattern, should be template
- ✅ **`immich.nix` detailed comments** — numbered sections explaining every decision
- ✅ **Rofi script ecosystem** — coherent keyboard-driven system UI
- ✅ **Vim-centric consistency** — hjkl/vim keybinds across all layers
- ✅ **Mini.files git integration** — 200 lines of impressive async work
- ✅ **NVIDIA Wayland tuning** — driver pinning, CDI, env vars all correct
- ✅ **Flake + traditional dotfiles hybrid** — pragmatic approach

---

## Implementation Priority Matrix

| Priority | Issue | Effort | Impact |
|----------|-------|--------|--------|
| 🔴 HIGH | ohMyZsh.custom bug | 5 min | Fixes zsh theme loading |
| 🔴 HIGH | Syncthing device ID | 5 min | Fixes sync functionality |
| 🔴 HIGH | Duplicate home.nix | 10 min | Removes tech debt |
| 🟡 MED  | Channel imports → flake | 30 min | Improves reproducibility |
| 🟡 MED  | Env vars consolidation | 45 min | Reduces maintenance burden |
| 🟡 MED  | Split common.nix | 60 min | Improves readability |
| 🟡 MED  | Hostname → options | 90 min | Improves architecture |
| 🟢 LOW  | Module options pattern | 120 min | Optional refinement |
| 🟢 LOW  | Fix backup files | 5 min | Cosmetic |
| 🟢 LOW  | Add root README | 30 min | Documentation |

---

## Recommended Implementation Order

1. **Session 1 (30 min):** Fix bugs
   - ohMyZsh.custom path
   - Syncthing device ID
   - Delete duplicate `nix/users/home.nix`
   - Clean up nvim backup files

2. **Session 2 (60 min):** Consistency pass
   - Convert channel imports to flake `unstable`
   - Server config: use flake home-manager
   - Consolidate env variables (single Nix source, propagate to Hyprland)

3. **Session 3 (90 min):** Architecture improvements
   - Split `common.nix` into domain files
   - Add hostname-based config gating via options
   - (Optional) Convert modules to options pattern

4. **Session 4 (30 min):** Polish
   - Add root README
   - Document module structure
   - Review for other hardcoded paths

---

## Questions to Resolve Later

- Should hostname-based config gating use `host.isDesktop` option or `device.form` (desktop/laptop/server)?
- Which secrets management (sops-nix vs agenix vs agenix-rekey)?
- Is `gtk.nix` intended to be Catppuccin-themed to match Hyprland, or left minimal?
- Should neovim be a proper home-manager flake input rather than a git submodule?
