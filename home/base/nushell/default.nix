{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.nushell;
in
{
  options.my.home.nushell = with lib; {
    enable = my.mkDisableOption "nushell configuration";
  };

  config = lib.mkIf cfg.enable {

    programs.nushell = {
      enable = true;
      configFile.source = ./config.nu;

      shellAliases = {
        vi = "nvim";
        vim = "nvim";
      };
    };
  };
}