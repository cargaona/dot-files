{ pkgs, lib, ... }:
{
  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://cuda-maintainers.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };
  nixpkgs.config.allowUnfree = true;

  # Specifically allow the required NVIDIA/CUDA packages
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "cuda_cccl"
      "cuda_cudart"
      "cuda_nvcc"
      "libcublas"
      "nvidia-settings"
      "nvidia-x11"
    ];
  services.ollama = {
    enable = true;
    acceleration = "cuda"; # Use "cuda" for NVIDIA or "rocm" for AMD
    host = "0.0.0.0";
    port = 11434;
    environmentVariables = {
      # Reserve ~1GB for Emby (1000000000 bytes)
      OLLAMA_GPU_OVERHEAD = "1000000000";
      # Keep the model in VRAM so it's always ready
      # OLLAMA_KEEP_ALIVE = "-1";
    };
  };
}
