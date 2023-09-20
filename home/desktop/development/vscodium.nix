{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.development;
in {
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
  };
}
