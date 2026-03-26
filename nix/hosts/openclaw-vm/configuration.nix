{
  config,
  pkgs,
  lib,
  home-manager,
  nix-openclaw,
  ...
}:

{
  imports = [
    # Include home-manager for user configuration
    home-manager.nixosModules.home-manager
  ];

  # VM-specific configuration
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096; # 4GB RAM
      graphics = false; # Headless VM

      # Port forwarding from host to guest
      forwardPorts = [
        {
          from = "host";
          host.port = 10022;
          guest.port = 22;
        }
        {
          from = "host";
          host.port = 18789;
          guest.port = 18789;
        }
      ];
    };
  };

  # System configuration
  system.stateVersion = "25.11";

  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages (in case OpenClaw or dependencies need them)
  nixpkgs.config.allowUnfree = true;

  # Networking
  networking.hostName = "openclaw-vm";
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    18789
    22
  ]; # Gateway and SSH

  # Time zone
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable SSH for management
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # User configuration
  users.users.openclaw = {
    isNormalUser = true;
    description = "OpenClaw AI Assistant User";
    extraGroups = [ "wheel" ]; # Enable sudo
    openssh.authorizedKeys.keys = [
      # Add your SSH public key here (same as char user)
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCiytR0RDJVFPwlPA+yBKUc6KhukzlPHCZ3ckaEZz5f5cXHp3g5dKZyOd7Kju7fEWa0apb37W9QZPa1PvreeJu6wpBs7FSNC6NpyjwnRjfpfbU1XC8WEVLzzgke+dV/7Ap98K2qpUoYAFIbYlAdGJAzMOc9BYKrb6l2ARIA26Fc2Zd7fUkdr8jcMQFv5qnFju1e82iPggeymNHKd7RNkuAg4nAfkTwNKxzcoF3rTBCc0iG0TE61uUbVOx6CVS/17Xj7g+YKS2jMuDE3nWi3Fl1PUx5J07DVFF4TzyxM2Srn8V39QSoCQDevyN1PZJcRW34GtgG2y1EEfJNVR1sP+GHak037L78JSyLfaDTB3uJzICOTdifFrc88SuauU+KMyyMnrP3h2YuWWurtOAZMGpPZlocFt8ILpC9j43fRtNbLwVe3dPTJDlDJJTZMjEVNrT1S6Xi6r7bYpq5jZgWNvPqByHnySrMsSwIGbuFfPoawVzbye6uliK8REiQV1azlMn0Lmv+YRwTURnpyiDmyAR3OxrB0CN9a0B8MLzp+IY1ZrLBxMCC/yRIWih2dOiLTri45qrt4Sul2NZYYPM9I2iwA8xezvp/Dr27gUKkixQVsCprRT8+J6fYVcVDOnzkDej/Hyem6oJqsGeSkjCmGCebBqJvxd5ZODD74A5HZzkLcrQ== cardno:15_206_941"
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    curl
    jq
  ];

  # Home Manager configuration
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.openclaw = import ./home.nix;
  home-manager.extraSpecialArgs = {
    inherit nix-openclaw;
  };
}
