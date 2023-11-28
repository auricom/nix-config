{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.profiles.x;
in {
  options.my.profiles.x = with lib; {
    enable = mkEnableOption "X profile";
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [pkgs.gnome.dconf-editor pkgs.gnome.networkmanager-openconnect];
      # ++ [
      #   pkgs.alacritty # pkgs.gnome-console
      #   pkgs.librewolf # pkgs.gnome.epiphany
      #   pkgs.flameshot # pkgs.gnome.gnome-screenshot
      # ];

      gnome.excludePackages = [
        pkgs.gnome-connections
        pkgs.gnome-console
        pkgs.gnome-photos
        pkgs.gnome-text-editor
        pkgs.gnome-tour
        pkgs.gnome.adwaita-icon-theme
        pkgs.gnome.epiphany
        # pkgs.gnome.evince              # document-viewer
        # pkgs.gnome.file-roller         # file-browser
        pkgs.gnome.geary
        pkgs.gnome.gnome-backgrounds
        pkgs.gnome.gnome-calendar
        pkgs.gnome.gnome-characters
        pkgs.gnome.gnome-clocks
        pkgs.gnome.gnome-contacts
        pkgs.gnome.gnome-font-viewer
        pkgs.gnome.gnome-logs
        pkgs.gnome.gnome-maps
        pkgs.gnome.gnome-music
        pkgs.gnome.gnome-screenshot
        pkgs.gnome.gnome-themes-extra
        pkgs.gnome.gnome-weather
        pkgs.gnome.simple-scan
        pkgs.gnome.sushi
        pkgs.gnome.totem
        pkgs.gnome.yelp
        pkgs.orca
      ];
    };

    services = {
      gnome = {
        gnome-browser-connector.enable = false;
        gnome-initial-setup.enable = false;
        gnome-online-accounts.enable = false;
      };

      # Get systray icons
      udev.packages = with pkgs; [gnome.gnome-settings-daemon];

      xserver = {
        # Enable the X11 windowing system.
        enable = true;

        excludePackages = [pkgs.xterm];

        # Enable the GNOME Desktop Environment.
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;

        # Enable automatic login for the user.
        displayManager.autoLogin.enable = true;
        displayManager.autoLogin.user = config.my.user.name;
      };
    };

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    # X configuration
    my.home.x.enable = true;
  };
}
