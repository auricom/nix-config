{...}:
{
  disko.devices = {
    disk = {
      sda = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ "--allow-discards" ];
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    # Subvolume name is different from mountpoint
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    # Subvolume name is the same as the mountpoint
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    # Sub(sub)volume doesn't need a mountpoint as its parent is mounted
                    "/home/claude" = { };
                    # Parent is not mounted so the mountpoint must be set
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
