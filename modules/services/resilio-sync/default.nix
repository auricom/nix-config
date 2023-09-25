# Resilio-Sync
{ config, lib, ... }:
let
  cfg = config.my.services.resilio-sync;
  hostName = config.networking.hostName;
in
{
  options.my.services.resilio-sync = {
    enable = lib.mkEnableOption "Resilio Sync configuration";
  };

  config = lib.mkIf cfg.enable {
    services.resilio = {
      enable = true;

      deviceName = hostName;
      enableWebUI = true;
      useUpnp = false;
      httpLogin = config.my.user.name;
      httpListenPort = 8888;
      httpListenAddr = "127.0.0.1";
    };
  };
}