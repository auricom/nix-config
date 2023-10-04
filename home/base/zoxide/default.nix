{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.zoxide;
in
{
  options.my.home.zoxide = with lib; {
    enable = my.mkDisableOption "zoxide configuration";
  };

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      zoxide
    ];

    programs.fish.interactiveShellInit = lib.mkIf fish.enable "zoxide init fish | source";

    programs.nushell = lib.mkIf nushell.enable {
      extraConfig = "source ~/.zoxide.nu";
      extraEnv = "zoxide init nushell | save -f ~/.zoxide.nu";
    }
  };
}