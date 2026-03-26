{ pkgs, lib, ... }:
{
  environment.systemPackages =
    with pkgs;
    lib.optionals pkgs.stdenv.isLinux [
      # Build tools & compilers
      cargo
      gcc
      gnumake
      go

      # Version control
      git

      # Language servers & formatters
      bash-language-server
      black # Python formatter
      ccls # C/C++ LSP
      gopls # Go LSP
      lua-language-server
      nil # Nix LSP
      nixfmt-rfc-style
      pyright # Python LSP
      terraform-ls
      typescript-language-server
      yaml-language-server

      # Runtimes & package managers
      lua
      luarocks
      nodejs_latest
      python3
      python312Packages.pip
      uv # Fast Python package installer
      yarn

      # Development tools
      claude-code
      tflint # Terraform linter
      tree-sitter
      vim
      virtualenv

      # Infrastructure as Code
      terraform
    ];
}
