{
  config,
  lib,
  pkgs,
  unstable,
  ...
}:

with lib;

let
  cfg = config.services.llm.ollama;
in
{
  options.services.llm.ollama = {
    enable = mkEnableOption "Ollama LLM inference service";

    acceleration = mkOption {
      type = types.str;
      default = "cuda";
      description = "Hardware acceleration type (cuda for NVIDIA, rocm for AMD)";
    };

    host = mkOption {
      type = types.str;
      default = "0.0.0.0";
      description = "Host address to bind Ollama service";
    };

    port = mkOption {
      type = types.port;
      default = 11434;
      description = "Port for Ollama service";
    };

    gpuOverhead = mkOption {
      type = types.str;
      default = "1000000000";
      description = "Amount of VRAM to reserve (in bytes, ~1GB default for other services)";
    };
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      package = unstable.ollama; # v0.17.4+ needed for `ollama launch`
      acceleration = cfg.acceleration;
      host = cfg.host;
      port = cfg.port;
      environmentVariables = {
        # Reserve VRAM for other services (e.g., Emby)
        OLLAMA_GPU_OVERHEAD = cfg.gpuOverhead;
        # Optionally keep model in VRAM indefinitely:
        # OLLAMA_KEEP_ALIVE = "-1";
      };
    };
  };
}
