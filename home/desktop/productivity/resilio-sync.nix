{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.productivity;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      resilio-sync
    ];

    # Resilio-sync
    xdg.configFile."resilio-sync/config.json".source = ./resilio-sync.config.json;

    systemd.user.services.resilio-sync = {
      Unit = {
        After = "network.target";
        Description = "Resilio Sync";
        Documentation = "https://help.resilio.com";
      };

      Service = {
        ExecStart = "/etc/profiles/per-user/${config.home.username}/bin/rslsync";
        ExecStartPost = "/bin/sleep 1";
      };

      WantedBy = "default.target";
    };
  };
}