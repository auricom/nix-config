{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  cfg = config.my.home.homelab;

  host = builtins.getEnv "hostname";
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      resilio-sync
    ];

    home.file."resilio.conf" = {
      enable = true;
      target = ".config/rslsync/rslsync.conf";
      text = ''
        {

          "device_name": "${osConfig.networking.hostName}",
          "storage_path" : "${config.xdg.configHome}/rslsync",
          "pid_file" : "${config.xdg.configHome}/rslsync/resilio.pid",
          "use_upnp" : false,
          "download_limit" : 0,
          "upload_limit" : 0,
          "directory_root" : "${config.home.homeDirectory}/",
          "webui" :
          {
            "listen" : "127.0.0.1:8888"
          }

        }
      '';
    };

    home.file."resilio" = {
      enable = true;
      target = ".local/bin/resilio";
      executable = true;
      text = ''
        #!/run/current-system/sw/bin/bash

        # Get the resolved path of autostart.sh
        rslsync_config=$(readlink -f ${config.xdg.configHome}/rslsync/rslsync.conf)
        # Run rslsync with the resolved path as config
        /etc/profiles/per-user/${config.home.username}/bin/rslsync --config $rslsync_config
      '';
    };

    systemd.user.services.resilio = {
      Unit = {
        Description = "Resilio";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash /home/${config.home.username}/.local/bin/resilio";
        RemainAfterExit = true;
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
