{ pkgs, ... }: {
  services.ollama = {
    enable = true;
    acceleration = "cuda"; # Use "cuda" for NVIDIA or "rocm" for AMD
  };
}
