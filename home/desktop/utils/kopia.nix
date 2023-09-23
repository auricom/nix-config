{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.utils;
in
{
  config = lib.mkIf cfg.enable {
    home.file.".kopiaignore".source = ./.kopiaignore;
    
    home.packages = with pkgs; [
      kopia
    ];
  };
}