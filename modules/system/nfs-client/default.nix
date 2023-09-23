# nfs-client related settings
{ config, lib, ... }:
let
  cfg = config.my.system.nfs-client;
in
{
  options.my.system.nfs-client = with lib; {
    enable = mkEnableOption "nfs-client configuration";
  };

  config = lib.mkIf cfg.enable {

    services.rpcbind.enable = true;

    systemd.mounts = let commonMountOptions = {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
    };

    in

    [
      (commonMountOptions // {
        what = "192.168.9.10:/mnt/storage/backups";
        where = "/mnt/truenas/backups";
      })

      (commonMountOptions // {
        what = "192.168.9.10:/mnt/storage/downloads";
        where = "/mnt/truenas/downloads";
      })

      (commonMountOptions // {
        what = "192.168.9.10:/mnt/storage/home-claude";
        where = "/mnt/truenas/home/claude";
      })

      (commonMountOptions // {
        what = "192.168.9.10:/mnt/storage/home-helene";
        where = "/mnt/truenas/home/helene";
      })

      (commonMountOptions // {
        what = "192.168.9.10:/mnt/storage/music";
        where = "/mnt/truenas/music";
      })

      (commonMountOptions // {
        what = "192.168.9.10:/mnt/storage/shared-documents";
        where = "/mnt/truenas/shared-documents";
      })

      (commonMountOptions // {
        what = "192.168.9.10:/mnt/storage/video";
        where = "/mnt/truenas/video";
      })
    ];

    systemd.automounts = let commonAutoMountOptions = {
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
    };

    in

    [
      (commonAutoMountOptions // { where = "/mnt/truenas/backups"; } )
      (commonAutoMountOptions // { where = "/mnt/truenas/downloads"; } )
      (commonAutoMountOptions // { where = "/mnt/truenas/home/claude"; } )
      (commonAutoMountOptions // { where = "/mnt/truenas/home/helene"; } )
      (commonAutoMountOptions // { where = "/mnt/truenas/music"; } )
      (commonAutoMountOptions // { where = "/mnt/truenas/shared-documents"; } )
      (commonAutoMountOptions // { where = "/mnt/truenas/video"; } )
    ];
  };
}