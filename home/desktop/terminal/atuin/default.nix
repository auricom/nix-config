{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.terminal;

  fish = config.my.home.fish;
  nushell = config.my.home.nushell;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      atuin
    ];

    programs.fish = lib.mkIf fish.enable {
      interactiveShellInit = "atuin init fish | source";
    };

    home.file.".local/share/atuin/init.nu".source = lib.mkIf nushell.enable ./init.nu;
  };
}
