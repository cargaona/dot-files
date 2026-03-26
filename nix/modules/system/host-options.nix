{ lib, ... }:
{
  options.host = {
    isDesktop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether this host is a desktop machine (enables desktop-only packages and services)";
    };
  };
}
