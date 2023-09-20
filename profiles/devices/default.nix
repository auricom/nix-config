{ config, lib, ... }:
let
  cfg = config.my.profiles.devices;
in
{
  options.my.profiles.devices = with lib; {
    enable = mkEnableOption "devices profile";
  };

}