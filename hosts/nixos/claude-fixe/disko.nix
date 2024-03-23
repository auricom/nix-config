{...}: {
  disko.devices = {
    disk = {
      nvme1n1 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Sabrent_A1850708125D02445956";
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
                extraOpenArgs = ["--allow-discards"];
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/home/claude" = {
                      mountpoint = "/home/claude";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/etc" = {
                      mountpoint = "/etc";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/etc/agenix" = {
                      mountpoint = "/etc/agenix";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["compress=zstd" "noatime"];
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
