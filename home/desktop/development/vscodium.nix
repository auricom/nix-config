{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.my.home.development;
in {
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.vscodium;
    };
  };
}
