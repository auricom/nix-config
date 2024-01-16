{...}: {
  networking = {
    hostName = "claude-laptop";

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
  };

  my.hardware.networking = {
    # Which interface is used to connect to the internet
    externalInterface = "wlp61s0";

    # Enable WiFi integration
    wireless.enable = true;
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
