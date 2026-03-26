{
  config,
  pkgs,
  lib,
  nix-openclaw,
  ...
}:

let
  # Get OpenClaw gateway package from nix-openclaw
  openclawGateway = nix-openclaw.packages.${pkgs.system}.openclaw-gateway;

  # OpenClaw configuration directory
  openclawConfig = pkgs.writeTextDir "openclaw.json" (
    builtins.toJSON {
      gateway = {
        mode = "local";
        bind = "0.0.0.0";
        port = 18789;
        auth = {
          # Will use OPENCLAW_GATEWAY_TOKEN from environment
        };
      };
      channels = {
        telegram = {
          tokenFile = "/home/openclaw/.secrets/telegram-bot-token";
          allowFrom = [
            123456789 # REPLACE WITH YOUR TELEGRAM USER ID
          ];
        };
      };
    }
  );

in
{
  # Home Manager configuration
  home.username = "openclaw";
  home.homeDirectory = "/home/openclaw";
  home.stateVersion = "25.11";

  # Install OpenClaw gateway
  home.packages = [
    openclawGateway
  ];

  # Create workspace directories
  home.file.".openclaw/workspace/.keep".text = "";

  # Copy documents to workspace
  home.file.".openclaw/workspace/AGENTS.md".source = ./documents/AGENTS.md;
  home.file.".openclaw/workspace/SOUL.md".source = ./documents/SOUL.md;
  home.file.".openclaw/workspace/TOOLS.md".source = ./documents/TOOLS.md;

  # Setup script for easy configuration
  home.file."setup-openclaw.sh" = {
    source = ./setup-openclaw.sh;
    executable = true;
  };

  # Basic shell configuration
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # OpenClaw environment
      export OPENCLAW_CONFIG_DIR="$HOME/.openclaw"
      export PATH="$HOME/.openclaw/bin:$PATH"
    '';
  };

  programs.git = {
    enable = true;
    userName = "OpenClaw VM";
    userEmail = "openclaw@localhost";
  };

  # Allow home-manager to manage itself
  programs.home-manager.enable = true;

  # Systemd user service for OpenClaw gateway
  # Note: Service is DISABLED by default - enable manually after setting up secrets
  systemd.user.services.openclaw-gateway = {
    Unit = {
      Description = "OpenClaw AI Assistant Gateway";
      After = [ "network.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${openclawGateway}/bin/openclaw gateway --port 18789 --verbose";
      Restart = "on-failure";
      RestartSec = "10s";

      # Environment variables
      Environment = [
        "OPENCLAW_CONFIG_DIR=%h/.openclaw"
        "OPENCLAW_WORKSPACE=%h/.openclaw/workspace"
        "NODE_ENV=production"
      ];

      # Load secrets from files if they exist
      EnvironmentFile = [
        "-%h/.secrets/env"
      ];
    };

    Install = {
      # Commented out to disable auto-start on boot
      # Enable after configuring secrets with: systemctl --user enable --now openclaw-gateway
      # WantedBy = [ "default.target" ];
    };
  };
}
