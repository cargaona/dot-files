# OpenClaw NixOS VM

This directory contains a complete NixOS VM configuration for running the OpenClaw AI assistant in isolation.

## What is OpenClaw?

OpenClaw is a personal AI assistant framework that connects to messaging platforms (Telegram, Discord, Slack, etc.) and provides intelligent responses and task automation. This VM setup allows you to run OpenClaw in a completely isolated environment.

## Prerequisites

1. Nix with flakes enabled
2. A Telegram bot token (from [@BotFather](https://t.me/BotFather))
3. Your Telegram user ID (from [@userinfobot](https://t.me/userinfobot))
4. (Optional) Anthropic API key for Claude models

## Setup Steps

### 1. Create Required Secrets

Navigate to the secrets directory and create your configuration files:

```bash
cd ../../secrets/openclaw

# Create Telegram bot token (get from @BotFather)
echo "YOUR_BOT_TOKEN" > telegram-bot-token

# Create gateway authentication token
openssl rand -hex 32 > gateway-token

# Optional: Add Anthropic API key
echo "sk-ant-YOUR_KEY" > anthropic-api-key

# Set proper permissions
chmod 600 telegram-bot-token gateway-token anthropic-api-key
```

See `../../secrets/openclaw/README.md` for detailed instructions.

### 2. Update Configuration

Edit `home.nix` and replace the placeholder Telegram user ID:

```nix
allowFrom = [
  123456789  # Replace with YOUR actual Telegram user ID
];
```

### 3. Build the VM

From the repository root:

```bash
# Update flake inputs
nix flake update

# Build the VM (this will download and build everything)
nix build .#nixosConfigurations.openclaw-vm.config.system.build.vm
```

This creates a `./result` symlink pointing to the VM build output.

### 4. Copy Secrets to VM Directory

The VM expects secrets in `/home/openclaw/.secrets/`. Since the VM starts fresh, you'll need to prepare a directory with secrets that can be mounted:

```bash
# Create a directory for VM secrets
mkdir -p vm-secrets

# Copy your secrets
cp ../../secrets/openclaw/telegram-bot-token vm-secrets/
cp ../../secrets/openclaw/gateway-token vm-secrets/

# Optional: copy API keys
cp ../../secrets/openclaw/anthropic-api-key vm-secrets/
```

### 5. Run the VM

```bash
# Run the VM (it will create a disk image on first run)
./result/bin/run-openclaw-vm-vm
```

The VM will:
- Start a QEMU virtual machine
- Create a disk image at `openclaw-vm.qcow2` (persistent storage)
- Forward port 18789 from guest to host
- Boot into NixOS with OpenClaw configured

### 6. Access the VM

#### SSH Access

From your host machine:

```bash
# The VM is accessible on localhost via forwarded SSH port
# Default SSH port forwarding should be configured
ssh openclaw@localhost -p 10022  # Port may vary, check VM output
```

Or if the VM uses standard NAT networking:

```bash
# You may need to add port forwarding manually
# Check the VM console output for the exact SSH port
```

#### Copy Secrets into Running VM

Once SSHed into the VM:

```bash
# Create secrets directory
mkdir -p ~/.secrets
chmod 700 ~/.secrets

# Exit SSH and copy secrets from host
exit

# From host: copy secrets to VM (adjust port as needed)
scp -P 10022 vm-secrets/* openclaw@localhost:~/.secrets/

# SSH back in and set permissions
ssh openclaw@localhost -p 10022
chmod 600 ~/.secrets/*
```

### 7. Start OpenClaw Service

Once secrets are in place:

```bash
# Check service status
systemctl --user status openclaw-gateway

# If not running, start it
systemctl --user start openclaw-gateway

# View logs
journalctl --user -u openclaw-gateway -f
```

### 8. Test the Bot

Send a message to your Telegram bot. It should respond!

```
You: /status
Bot: [session status information]

You: Hello!
Bot: [AI-generated response]
```

## VM Management

### Stop the VM

Simply close the QEMU window or send shutdown signal:

```bash
# From inside the VM
sudo poweroff
```

### Restart the VM

```bash
./result/bin/run-openclaw-vm-vm
```

The VM disk image (`openclaw-vm.qcow2`) persists between runs, so your configuration and state are preserved.

### Rebuild After Configuration Changes

After modifying any `.nix` files:

```bash
# Rebuild the VM
nix build .#nixosConfigurations.openclaw-vm.config.system.build.vm --rebuild

# Run the updated VM
./result/bin/run-openclaw-vm-vm
```

### Delete VM and Start Fresh

```bash
# Remove the disk image
rm openclaw-vm.qcow2

# Remove the result symlink
rm result

# Rebuild and run
nix build .#nixosConfigurations.openclaw-vm.config.system.build.vm
./result/bin/run-openclaw-vm-vm
```

## Troubleshooting

### VM Won't Build

Check flake inputs are up to date:

```bash
nix flake update
nix flake check
```

### OpenClaw Service Won't Start

Check the logs:

```bash
# Inside the VM
journalctl --user -u openclaw-gateway -n 50
```

Common issues:
- Missing secrets files
- Incorrect file paths in configuration
- Invalid Telegram bot token
- Network connectivity issues

### Can't Connect to Telegram

Verify:
1. Bot token is correct (`~/.secrets/telegram-bot-token`)
2. Your user ID is in the `allowFrom` list in `home.nix`
3. VM has internet connectivity (ping google.com)
4. Gateway service is running

### Port Forwarding Not Working

Check the VM console output for the actual forwarded ports. The configuration attempts to forward:
- Port 18789 (OpenClaw gateway)
- Port 22 (SSH) - may be mapped to different host port

## Configuration Files

- `configuration.nix` - NixOS system configuration
- `home.nix` - Home Manager configuration for the `openclaw` user
- `documents/` - OpenClaw AI personality and capabilities docs
  - `AGENTS.md` - Main agent configuration
  - `SOUL.md` - AI personality and values
  - `TOOLS.md` - Available tools and capabilities

## Architecture

```
Host Machine
    ↓
QEMU VM (NixOS)
    ↓
User: openclaw
    ↓
Home Manager → OpenClaw Gateway Service
    ↓
Telegram Bot ←→ Your Telegram Client
```

## Security Notes

1. The VM runs isolated from your host system
2. Secrets are stored in the VM's home directory (not in Nix store)
3. The gateway requires authentication token to connect
4. Telegram bot only responds to whitelisted user IDs
5. SSH access is key-based only (no password authentication)

## Advanced: Customization

### Add More Plugins

Edit `home.nix` and add plugins to the `bundledPlugins` section or `instances.default.plugins`:

```nix
bundledPlugins = {
  summarize.enable = true;
  peekaboo.enable = true;
  # Add more bundled plugins
  poltergeist.enable = true;  # UI control (may not work in headless VM)
};

instances.default.plugins = [
  { source = "github:owner/custom-plugin"; }
];
```

### Adjust VM Resources

Edit `configuration.nix`:

```nix
virtualisation = {
  memorySize = 8192;  # 8GB RAM
  cores = 4;          # 4 CPU cores
};
```

### Enable Graphics

If you want to run the VM with a graphical console:

```nix
virtualisation.graphics = true;  # Enable graphics
```

## Further Reading

- [OpenClaw Documentation](https://docs.openclaw.ai)
- [nix-openclaw Repository](https://github.com/openclaw/nix-openclaw)
- [NixOS VM Configuration](https://nixos.wiki/wiki/NixOS:nixos-rebuild_build-vm)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
