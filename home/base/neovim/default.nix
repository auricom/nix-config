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
      neovim
    ];

    programs.fish.shellAliases = lib.mkIf fish.enable {
      vi = "nvim";
      vim = "nvim";
    };

    programs.nushell.shellAliases = lib.mkIf nushell.enable {
      vi = "nvim";
      vim = "nvim";
    };
  };
}
