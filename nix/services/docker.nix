{ pkgs, ... }:
{
  virtualisation = {
    oci-containers.backend = "docker";
    docker = {
      daemon.settings.features.cdi = true;
      enable = true;
      enableOnBoot = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
  hardware.nvidia-container-toolkit.enable = true;
}
