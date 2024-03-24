{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.development;
  fish = config.my.home.fish;
  nushell = config.my.home.nushell;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      direnv
    ];

    programs = {
      fish.shellAliases.trunk = lib.mkIf cfg.enable "/home/claude/.cache/trunk/launcher/trunk";
      nushell.shellAliases.trunk = lib.mkIf nushell.enable "/home/claude/.cache/trunk/launcher/trunk";
    };
  };
}
