{ pkgs, ... }:
{
  services.immich = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0";
    mediaLocation = "/mnt/seagate/immich";
    # Pass the device nodes you just listed to the service
    accelerationDevices = [
      "/dev/nvidia0"
      "/dev/nvidiactl"
      "/dev/nvidia-uvm"
    ];
  };
  nixpkgs.config.cudaSupport = true;
  nixpkgs.config.allowUnfree = true;
  # 2. Tell the ML service where to put its cache and models
  services.immich.machine-learning.environment = {
    # Fixes the Matplotlib error you see in the logs
    MPLCONFIGDIR = "/var/lib/immich/.config/matplotlib";
    # Fixes the model download error
    HF_HOME = "/var/lib/immich/.cache/huggingface";
    # Extra cache path for newer versions
    PPL_CACHE_HOME = "/var/lib/immich/.cache/ppl";
  };

  # 3. Ensure the service can actually write to its home
  systemd.services.immich-machine-learning.serviceConfig = {
    WorkingDirectory = "/var/lib/immich";
    ReadWritePaths = [
      "/var/lib/immich"
      "/tmp"
    ];
  };
  # systemd.services.immich-machine-learning.serviceConfig = {
  #   PrivateDevices = pkgs.lib.mkForce false;
  #   DeviceAllow = [
  #     "/dev/nvidia0"
  #     "/dev/nvidiactl"
  #     "/dev/nvidia-uvm"
  #   ];
  # };
}
