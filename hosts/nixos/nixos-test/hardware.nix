{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/fe074c6b-9bc0-4ed3-b83a-323344042dd5";
      fsType = "ext4";
    };
  };

  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;
}
