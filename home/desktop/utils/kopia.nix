{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.utils;
in {
  config = lib.mkIf cfg.enable {
    home.file.".kopiaignore".source = ./.kopiaignore;

    home.packages = with pkgs; [
      auricom.kopia-ui
      kopia
    ];

    systemd.user.services.kopia-ui = {
      Unit = {
        Description = "Kopia UI";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "/etc/profiles/per-user/${config.home.username}/bin/kopia-ui";
        RemainAfterExit = true;
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
