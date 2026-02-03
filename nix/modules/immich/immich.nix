{
  config,
  pkgs,
  lib,
  ...
}:

{
  # 1. STOP THE HANGING: Disable global CUDA to avoid OOM during rebuild.
  # This ensures Nix uses pre-compiled CPU binaries from the cache.
  nixpkgs.config.cudaSupport = false;
  nixpkgs.config.allowUnfree = true;

  # 2. CREATE A WRITABLE HOME: Fixes the "/var/empty" error in your logs.
  users.users.immich = {
    isSystemUser = true;
    group = "immich";
    home = "/var/lib/immich";
    createHome = true;
  };
  users.groups.immich = { };

  # 3. CORE IMMICH SERVICE
  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    mediaLocation = "/mnt/seagate/immich";
    openFirewall = true;

    # In NixOS, you don't use 'acceleration = "none"'.
    # You just leave accelerationDevices empty or null.
    accelerationDevices = null;
  };

  # 4. MACHINE LEARNING ENVIRONMENT: Fixes the Matplotlib/HuggingFace errors.
  services.immich.machine-learning.environment = {
    MPLCONFIGDIR = "/var/lib/immich/.config/matplotlib";
    HF_HOME = "/var/lib/immich/.cache/huggingface";
    PPL_CACHE_HOME = "/var/lib/immich/.cache/ppl";
  };

  # 5. SYSTEMD OVERRIDES: Grant the AI service permission to use its home.
  systemd.services.immich-machine-learning.serviceConfig = {
    WorkingDirectory = "/var/lib/immich";
    # 'lib.mkForce' ensures these paths override the default sandboxing.
    ReadWritePaths = lib.mkForce [
      "/var/lib/immich"
      "/mnt/seagate/immich"
      "/tmp"
    ];
    # This prevents the service from defaulting back to /var/empty.
    PrivateDevices = false;
  };
  # 1. Ensure the directory exists on the Seagate first
  systemd.tmpfiles.rules = [
    "d /mnt/seagate/immich/thumbs 0750 immich immich -"
  ];

  # 2. Bind the NVMe folder to the Immich thumbs directory
  systemd.mounts = [
    {
      description = "Bind Mount Immich Thumbs to NVMe";
      what = "/mnt/nvme/immich-thumbs";
      where = "/mnt/seagate/immich/thumbs";
      type = "none";
      options = "bind";
      wantedBy = [
        "immich-server.service"
        "immich-microservices.service"
      ];
      before = [
        "immich-server.service"
        "immich-microservices.service"
      ];
    }
  ];

  # 3. Add NVMe to allowed paths for Systemd
  systemd.services.immich-server.serviceConfig.ReadWritePaths = [ "/mnt/nvme/immich-thumbs" ];
  systemd.services.immich-microservices.serviceConfig.ReadWritePaths = [ "/mnt/nvme/immich-thumbs" ];
}
