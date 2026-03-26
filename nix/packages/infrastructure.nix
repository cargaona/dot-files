{ pkgs, lib, ... }:
{
  environment.systemPackages =
    with pkgs;
    lib.optionals pkgs.stdenv.isLinux [
      # Container tools
      docker # TODO: Remove after server migration to Podman
      podman
      podman-compose

      # Kubernetes tools
      k9s
      kubectl
      kubectl-neat
      kubectx
      kubernetes-helm

      # GPU & Media
      gpu-screen-recorder
<<<<<<< Updated upstream
      (pkgs.llama-cpp.override { cudaSupport = true; })
=======
>>>>>>> Stashed changes
    ];
}
