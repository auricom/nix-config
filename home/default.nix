{...}: {
  imports = [
    ./base
    ./desktop
    ./secrets
  ];

  # First sane reproducible version
  home.stateVersion = "23.11";

  # Start services automatically
  systemd.user.startServices = "sd-switch";
}
