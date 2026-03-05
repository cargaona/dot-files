# Kramer Host Configuration

Minimal NixOS desktop configuration for initial installation and SSH access.

## Initial Setup

```bash
# On the kramer machine after NixOS installation:
sudo nixos-rebuild switch --flake github:cargaona/dot-files#kramer

# Or from local clone:
sudo nixos-rebuild switch --flake /path/to/dot-files/nix#kramer
```

## Activating Additional Services

The configuration is minimal by default. Uncomment modules in `configuration.nix` to enable:

### Desktop Environment

**Hyprland:**
1. Uncomment in `configuration.nix`:
   - `../../modules/desktop/hyprland.nix`
   - `../../modules/desktop/fonts.nix`
   - `../../modules/desktop/input.nix`
2. Uncomment in `flake.nix` (line ~69):
   - `hyprland.nixosModules.default` in modules
   - `inherit hyprland caelestia-shell mpris-inhibit;` in specialArgs
3. Update home-manager block to include caelestia-shell:
   ```nix
   home-manager.extraSpecialArgs = {
     inherit caelestia-shell;
   };
   
   home-manager.users.char = {
     pkgs,
     lib,
     caelestia-shell,
     ...
   }: {
     imports = [
       caelestia-shell.homeManagerModules.default
       ../../home/home.nix
     ];
   };
   ```

**COSMIC:**
- Uncomment `../../modules/desktop/cosmic.nix`

### Hardware

**NVIDIA GPU:**
- Uncomment `../../modules/hardware/nvidia.nix`

**Audio:**
- Uncomment `../../modules/hardware/audio.nix`

**Power Management:**
- Uncomment `../../modules/hardware/power.nix`

**Kindle Auto-mount:**
- Uncomment `../../modules/hardware/kindle.nix`
- Configure UUID in the hardware.kindle block

### Services

**Ollama (LLM):**
1. Uncomment `../../modules/llm/ollama.nix`
2. Uncomment the `services.llm.ollama` configuration block
3. Adjust settings as needed (acceleration, port, gpuOverhead)

**Docker:**
- Uncomment `../../modules/virtualization/docker.nix`

**Android Development:**
- Uncomment `../../modules/dev/android.nix`

## After Changes

```bash
# Rebuild the system
sudo nixos-rebuild switch --flake .#kramer

# Or remotely via SSH:
nixos-rebuild switch --flake .#kramer --target-host char@kramer --use-remote-sudo
```

## Current State

- ✅ SSH access
- ✅ User account (char) with GPG/Yubikey support
- ✅ Home-manager dotfiles (zsh, neovim, tmux, alacritty)
- ✅ All CLI packages from common.nix
- ✅ Network access (NetworkManager)
- ❌ Desktop environment (uncomment hyprland/cosmic to enable)
- ❌ NVIDIA drivers (uncomment nvidia.nix to enable)
- ❌ Audio (uncomment audio.nix to enable)
- ❌ Docker (uncomment docker.nix to enable)
- ❌ Ollama (uncomment ollama.nix to enable)
