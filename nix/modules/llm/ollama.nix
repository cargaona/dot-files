{
  pkgs,
  lib,
  unstable,
  ...
}:
{
  # nixpkgs.config.allowUnfree = true;
  services.ollama = {
    enable = true;
    package = unstable.ollama; # v0.17.4+ needed for `ollama launch`
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
