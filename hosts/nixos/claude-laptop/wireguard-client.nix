{ config, lib, pkgs, ... }:

{
  age.secrets."wireguard/wg.conf" = {
    path = "$HOME/wg.conf";
  };
    
  services.wg-netmanager.enable = true;
}