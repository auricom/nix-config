{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.starship;
in
{
  options.my.home.starship = with lib; {
    enable = mkEnableOption "starship configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      # custom settings
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };
  };
}