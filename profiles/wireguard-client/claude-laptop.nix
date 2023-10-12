{ config, lib, ... }:
let
  cfg = config.my.profiles.wireguard-client-claude-laptop;
in
{
  options.my.profiles.wireguard-client-claude-laptop = with lib; {
    enable = mkEnableOption "wireguard-client-claude-laptop profile";
  };

  config = lib.mkIf cfg.enable {
    # Enable wireguard-client
    my.home.wireguard-client-claude-laptop.enable = true;
    services.wg-netmanager.enable = true;
  };
}