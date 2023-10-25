{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.development;
  fish = config.my.home.fish;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      direnv
    ];
  };
}
