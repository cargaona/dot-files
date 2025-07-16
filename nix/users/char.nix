{
  pkgs,
  ...
}:

{
  # --- User Definitions ---
  users.users.char = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCiytR0RDJVFPwlPA+yBKUc6KhukzlPHCZ3ckaEZz5f5cXHp3g5dKZyOd7Kju7fEWa0apb37W9QZPa1PvreeJu6wpBs7FSNC6NpyjwnRjfpfbU1XC8WEVLzzgke+dV/7Ap98K2qpUoYAFIbYlAdGJAzMOc9BYKrb6l2ARIA26Fc2Zd7fUkdr8jcMQFv5qnFju1e82iPggeymNHKd7RNkuAg4nAfkTwNKxzcoF3rTBCc0iG0TE61uUbVOx6CVS/17Xj7g+YKS2jMuDE3nWi3Fl1PUx5J07DVFF4TzyxM2Srn8V39QSoCQDevyN1PZJcRW34GtgG2y1EEfJNVR1sP+GHak037L78JSyLfaDTB3uJzICOTdifFrc88SuauU+KMyyMnrP3h2YuWWurtOAZMGpPZlocFt8ILpC9j43fRtNbLwVe3dPTJDlDJJTZMjEVNrT1S6Xi6r7bYpq5jZgWNvPqByHnySrMsSwIGbuFfPoawVzbye6uliK8REiQV1azlMn0Lmv+YRwTURnpyiDmyAR3OxrB0CN9a0B8MLzp+IY1ZrLBxMCC/yRIWih2dOiLTri45qrt4Sul2NZYYPM9I2iwA8xezvp/Dr27gUKkixQVsCprRT8+J6fYVcVDOnzkDej/Hyem6oJqsGeSkjCmGCebBqJvxd5ZODD74A5HZzkLcrQ== cardno:15_206_941"
    ];
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user
    packages = with pkgs; [
      tree
    ];
  };

  # Firefox configuration moved to packages/common.nix for cross-platform compatibility
  # User-specific Firefox profiles and extensions can be configured here if needed

  # Default user shell (Zsh)
  users.defaultUserShell = pkgs.zsh;

  # --- Security Settings ---
  security.sudo.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    # pinentryPackage = "pinentry-gtk2";
  };

  # services.udev.packages = [ pkgs.yubikey-personalization ];

  programs.ssh.extraConfig = ''
    ForwardAgent yes
  '';

  programs.git.config = {
    user.name = "nq";
    user.email = "nq@nq.io";
  };

  # --- Services ---
  services.dbus.enable = true;
}
