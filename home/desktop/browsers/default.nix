{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.browsers;
in
{
  imports = [
    ./chromium.nix
    # ./firefox.nix
    ./librewolf.nix
  ];

  options.my.home.browsers = with lib; {
    enable = mkEnableOption "browsers configuration";
  };

}