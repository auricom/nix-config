{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.packages;
  fish = config.my.home.fish;
  nushell = config.my.home.nushell;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      lsd
      vivid # generator for LS_COLORS
    ];

    xdg.configFile."lsd/config.yaml".source = ./config.yaml;

    programs.fish.shellAliases = lib.mkIf fish.enable {
      l = "lsd -alh";
      ls = "lsd";
      ll = "lsd -l";
    };

    programs.nushell.shellAliases = lib.mkIf nushell.enable {
      l = "lsd -alh";
      ls = "lsd";
      ll = "lsd -l";
    };
  };
}
