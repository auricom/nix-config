{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.git;
in
{
  options.my.home.git = with lib; {
    enable = mkEnableOption "git configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "auricom";
      userEmail = "27022259+auricom@users.noreply.github.com";
    };
  };
}