# nfs-client related settings
{
  config,
  lib,
  ...
}: let
  cfg = config.my.system.nfs-client;
in {
  options.my.system.nfs-client = with lib; {
    enable = mkEnableOption "nfs-client configuration";
  };

  config = lib.mkIf cfg.enable {
    networking.hosts."192.168.9.10" = ["truenas"];

    fileSystems."/mnt/truenas/backups" = {
      device = "truenas:/mnt/storage/backups";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };

    fileSystems."/mnt/truenas/downloads" = {
      device = "truenas:/mnt/storage/downloads";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };

    fileSystems."/mnt/truenas/home-claude" = {
      device = "truenas:/mnt/storage/home/claude";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };

    fileSystems."/mnt/truenas/home-helene" = {
      device = "truenas:/mnt/storage/home/helene";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };

    fileSystems."/mnt/truenas/music" = {
      device = "truenas:/mnt/storage/music";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };

    fileSystems."/mnt/truenas/shared-documents" = {
      device = "truenas:/mnt/storage/shared-documents";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };

    fileSystems."/mnt/truenas/video" = {
      device = "truenas:/mnt/storage/video";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };

    networking.hosts."192.168.9.13" = ["openmediavault"];

    fileSystems."/mnt/openmediavault/frigate" = {
      device = "openmediavault:/export/frigate";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
  };
}
