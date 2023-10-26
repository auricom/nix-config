{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems."/etc/agenix".neededForBoot = true;

  time.hardwareClockInLocalTime = true;
}
