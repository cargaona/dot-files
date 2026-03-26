# Dotfiles

Personal dotfiles and NixOS system configuration with declarative home-manager integration.

## Architecture

Hybrid approach combining NixOS flakes with traditional dotfiles:
- **Nix flake** — Declarative system configuration and package management
- **Dotfiles** — Symlinked configs for Hyprland, Neovim, Zsh, Tmux, etc.
- **Home Manager** — User-level package and dotfile management

### Hosts

- **desktop** (`sff`) — Primary workstation (NixOS, Hyprland/COSMIC, NVIDIA)
- **server** (`elaine`) — Home server (NixOS, k3s, Immich, Ollama)
- **macbook** — macOS laptop (nix-darwin)

## Quick Start

### NixOS

```bash
# Clone the repository
git clone https://github.com/cargaona/dot-files.git ~/projects/personal/code/dot-files
cd ~/projects/personal/code/dot-files/nix

# Build and switch (desktop)
sudo nixos-rebuild switch --flake .#desktop

# Build and switch (server)
sudo nixos-rebuild switch --flake .#server
```

### macOS (nix-darwin)

```bash
# Build and switch
darwin-rebuild switch --flake .#macbook
```

## Directory Structure

```
.
├── nix/                      # NixOS & nix-darwin configurations
│   ├── flake.nix            # Flake entrypoint
│   ├── hosts/               # Per-host configurations
│   │   ├── desktop/         # Desktop workstation config
│   │   ├── server/          # Server config
│   │   └── macbook/         # macOS config
│   ├── modules/             # Modular NixOS configurations
│   │   ├── desktop/         # Desktop environment (Hyprland, COSMIC)
│   │   ├── hardware/        # Hardware-specific (NVIDIA, audio, Kindle)
│   │   ├── network/         # Network services (SSH)
│   │   ├── llm/             # LLM services (Ollama)
│   │   ├── kubernetes/      # Container orchestration (k3s)
│   │   ├── immich/          # Photo management
│   │   └── virtualization/  # Docker, Podman
│   ├── packages/            # Package lists by category
│   │   ├── cli.nix          # Terminal tools
│   │   ├── dev.nix          # Development tools
│   │   ├── desktop.nix      # GUI applications
│   │   └── infrastructure.nix # Container/k8s tools
│   ├── home/                # Home Manager configurations
│   │   ├── home.nix         # User environment & dotfile symlinks
│   │   └── caelestia-config.nix # Caelestia shell settings
│   └── users/               # User account definitions
├── hypr/                    # Hyprland window manager config
│   └── hyprland/           # Modular Hyprland configs
├── nvim/                    # Neovim configuration
├── zsh/                     # Zsh shell config & theme
├── tmux/                    # Tmux terminal multiplexer
├── alacritty/              # Alacritty terminal emulator
├── rofi/                    # Rofi application launcher
├── scripts/                 # Shell scripts (aiterm, etc.)
└── DOTFILES_REVIEW.md      # Improvement roadmap
```

## Key Features

- **Declarative system configuration** with NixOS flakes
- **Categorized package management** (dev, CLI, desktop, infrastructure)
- **Host-specific options** (`host.isDesktop`) for conditional config
- **Cross-platform support** (NixOS + macOS via nix-darwin)
- **Modular architecture** with proper options patterns
- **Hyprland + COSMIC** desktop environments with NVIDIA support
- **Kubernetes homelab** (k3s, Ollama, Immich)
- **Vim-centric workflow** across all layers (Neovim, shell, window manager)

## Development Workflow

- **Hyprland** — Tiling window manager with 10 modular config files
- **Neovim** — Lua-based config with LSP, Treesitter, Mini.files
- **Zsh** — Oh-My-Zsh with custom minimal theme and vim mode
- **Tmux** — Terminal multiplexer with vim keybinds
- **Rofi** — Keyboard-driven launcher ecosystem

## Improvements & Roadmap

See [DOTFILES_REVIEW.md](DOTFILES_REVIEW.md) for the prioritized improvement roadmap, including:
- ✅ Bug fixes (ohMyZsh path, sync cleanup)
- ✅ Flake purity (channel imports eliminated)
- ✅ Package organization (split into domain modules)
- ✅ Host options pattern (replaced hostname checks)
- Future: Secrets management (sops-nix/agenix), GTK theming, further module refactoring

## License

Personal configuration — use at your own risk. No warranty provided.
