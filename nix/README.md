# NixOS Dotfiles Configuration

A comprehensive NixOS configuration repository for managing multiple hosts with a modular, flake-based approach. This repository provides a unified system configuration for desktop, server, and macOS environments.

## Overview

This repository contains a sophisticated NixOS configuration that manages:
- **Multiple hosts** (costanza, elaine, kramer) with specialized configurations
- **Modular services** for audio, docker, networking, and power management
- **Cross-platform dotfiles** using Home Manager
- **Wayland desktop environment** with Hyprland window manager
- **Development environment** with modern tools and languages

## Repository Structure

```
nix/
├── flake.nix              # Main flake configuration
├── flake.lock             # Dependency lock file
├── hosts/                 # Host-specific configurations
│   ├── costanza/         # Primary desktop (DeepCool CH170)
│   ├── elaine/            # Secondary desktop (Dan A4 SFX)
│   └── kramer/            # Home server (NR200)
├── modules/               # Reusable NixOS modules by domain
│   ├── desktop/          # Desktop environment & UI
│   │   ├── hyprland.nix
│   │   ├── fonts.nix
│   │   ├── gtk.nix
│   │   └── input.nix
│   ├── hardware/         # Hardware-specific configurations
│   │   ├── audio.nix
│   │   ├── nvidia.nix
│   │   └── power.nix
│   ├── network/          # Network services and configuration
│   │   ├── ssh.nix
│   │   └── sync.nix
│   ├── virtualization/   # Containerization and VMs
│   │   ├── docker.nix
│   │   └── server.nix
│   └── platform/         # Platform-specific (linux/darwin)
│       ├── linux/
│       └── darwin/
├── packages/             # Package definitions
│   └── common.nix       # Common packages across platforms
├── home/                 # Home Manager configurations
│   └── home.nix
└── users/                # User-specific configurations
    └── char.nix
```

## Features

### Multi-Host Support
- **costanza**: Primary desktop (DeepCool CH170) — Hyprland, NVIDIA, Ollama, Caelestia shell
- **elaine**: Secondary desktop (Dan A4 SFX) — Hyprland, NVIDIA, Caelestia shell
- **kramer**: Home server (NR200) — k3s, Immich, Docker

### Modern Development Environment
- **Languages**: Python, Go, JavaScript/TypeScript, Lua, Nix
- **Tools**: Neovim, Alacritty, Zsh with Oh My Zsh
- **Cloud**: AWS CLI, kubectl, Docker/Podman
- **Security**: GnuPG, password-store, SSH key management

### Wayland Desktop (Linux)
- **Window Manager**: Hyprland with proper NVIDIA support
- **Status Bar**: Waybar with custom configuration
- **Launcher**: Rofi with custom themes
- **Notifications**: Dunst
- **Screenshots**: Grim + Slurp + Swappy

### Cross-Platform Dotfiles
- **Terminal**: Alacritty configuration
- **Editor**: Neovim with comprehensive plugin setup
- **Shell**: Zsh with Oh My Zsh and custom configuration
- **News**: Newsboat RSS reader
- **Version Control**: Git with global configuration

## Installation

### Prerequisites
- NixOS 25.11 or compatible system
- Nix with flakes enabled
- Git for cloning the repository

### Quick Setup

1. **Clone the repository**:
```bash
git clone <repository-url> ~/projects/personal/code/dot-files
cd ~/projects/personal/code/dot-files/nix
```

2. **Enable flakes** (if not already enabled):
```bash
echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
```

3. **Build and switch to configuration**:
```bash
# For costanza (primary desktop)
sudo nixos-rebuild switch --flake .#costanza

# For elaine (secondary desktop)
sudo nixos-rebuild switch --flake .#elaine

# For kramer (server)
sudo nixos-rebuild switch --flake .#kramer
```

### Manual Installation Steps

1. **Hardware configuration**: Ensure `/etc/nixos/hardware-configuration.nix` exists
2. **User setup**: Modify `users/char.nix` for your user preferences
3. **SSH keys**: Update SSH authorized keys in `users/char.nix`
4. **Host-specific settings**: Adjust networking and hardware settings in host configurations

## Usage

### Basic Commands

```bash
# Rebuild system configuration
sudo nixos-rebuild switch --flake .#<hostname>

# Test configuration without switching
sudo nixos-rebuild test --flake .#<hostname>

# Update flake inputs
nix flake update

# Show system configuration
nixos-rebuild show-config

# Home Manager operations
home-manager switch --flake .#<hostname>
```

### Development Workflow

1. **Edit configuration files** in appropriate modules
2. **Test changes** with `nixos-rebuild test`
3. **Apply changes** with `nixos-rebuild switch`
4. **Commit changes** to version control

### Common Customizations

#### Adding New Packages
Edit `packages/common.nix`:
```nix
environment.systemPackages = sharedPackages ++ linuxPackages ++ darwinPackages;
```

#### Configuring Modules
Create or modify files in appropriate `modules/` subdirectories:
```nix
# modules/network/my-service.nix
{ ... }:
{
  systemd.services.my-service = {
    enable = true;
    # service configuration
  };
}
```

#### Host-Specific Configuration
Modify host files in `hosts/<hostname>/configuration.nix`:
```nix
{
  imports = [
    # Add new module imports
    ../../modules/network/my-service.nix
  ];
  
  # Host-specific settings
  networking.hostName = "my-hostname";
}
```

### Troubleshooting

#### Common Issues

1. **Build failures**: Check syntax with `nix flake check`
2. **Missing hardware config**: Ensure `/etc/nixos/hardware-configuration.nix` exists
3. **Unfree packages**: Verify `nixpkgs.config.allowUnfree = true;`
4. **Home Manager conflicts**: Run `home-manager switch` separately

#### Debugging Commands

```bash
# Check flake syntax
nix flake check

# Show derivation
  nix show-derivation .#nixosConfigurations.costanza.config.system.build.toplevel

# Debug build process
  nixos-rebuild switch --flake .#costanza --show-trace
```

## Advanced Configuration

### Adding New Hosts
1. Create `hosts/<hostname>/configuration.nix`
2. Add host to `flake.nix`:
```nix
nixosConfigurations."<hostname>" = nixpkgs.lib.nixosSystem {
  modules = [ ./hosts/<hostname>/configuration.nix ];
};
```

### Custom Services
Create modular services in `services/` directory with proper imports and options.

### Security Considerations
- SSH keys are managed through authorized_keys
- GnuPG agent with SSH support enabled
- Password store with Wayland extensions
- Proper firewall configuration per host

## Contributing

When making changes:
1. Test on a non-production system first
2. Follow the modular structure
3. Document significant changes
4. Use descriptive commit messages
5. Consider impact on all configured hosts

This configuration provides a solid foundation for a modern NixOS development environment with cross-platform dotfiles management.
