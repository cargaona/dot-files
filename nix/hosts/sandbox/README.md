# Sandbox VM

Arch Linux QEMU virtual machine for experimentation. Nix only provides the launch script — everything inside the VM is manual and mutable.

## Quick Start

```bash
# Launch the VM (downloads Arch cloud image on first run)
nix run .#sandbox

# SSH in (once booted, ~30 seconds)
ssh sandbox@localhost -p 10022
```

## What Happens on First Run

1. Downloads the official Arch Linux cloud image (~500MB)
2. Creates a 20GB copy-on-write disk backed by the cloud image
3. Generates a cloud-init ISO that creates user `sandbox` with your SSH key
4. Boots the VM

Subsequent runs reuse the existing disk — your changes persist.

## Port Forwarding

| Host Port | Guest Port | Service |
|-----------|------------|---------|
| 10022     | 22         | SSH     |
| 18789     | 18789      | General |

## VM Controls

- **Exit QEMU**: `Ctrl-A X`
- **Shutdown from inside**: `sudo poweroff`

## Data Location

All VM state is stored in `~/.local/share/sandbox-vm/`:

- `arch.qcow2` — VM disk (persistent)
- `arch.qcow2.base` — Original cloud image (do not delete while disk exists)
- `cidata.iso` — Cloud-init data

### Reset the VM

```bash
rm -rf ~/.local/share/sandbox-vm/
nix run .#sandbox  # Fresh start
```

## Configuration

The VM runs with:
- 4GB RAM, 2 CPU cores (KVM-accelerated)
- Headless (no graphics, serial console)
- User `sandbox` with passwordless sudo
- SSH key-based authentication only

To change VM resources, edit `packages/sandbox-vm.nix`.

## Documents

The `documents/` directory contains reference material for OpenClaw configuration (AGENTS.md, SOUL.md, TOOLS.md).
