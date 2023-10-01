{ inputs, lib, pkgs, ...}:
let
  inherit (lib) mapAttrs' nameValuePair mkForce;
  keys = import ../keys;
in {
  environment.systemPackages = with pkgs; [
    helix
    vim
    curl
    wget
    httpie
    diskrsync
    partclone
    ntfsprogs
    ntfs3g
  ];

  # Use helix as the default editor
  environment.variables.EDITOR = "hx";

  networking = {
    firewall.enable = false;
    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
    ];
    usePredictableInterfaceNames = false;
  };

  services.resolved.enable = false;

  systemd = {
    network.enable = true;
    network.networks =
      mapAttrs'
      (num: _:
        nameValuePair "eth${num}" {
          extraConfig = ''
            [Match]
            Name = eth${num}
            [Network]
            DHCP = both
            LLMNR = true
            IPv4LL = true
            LLDP = true
            [DHCP]
            UseHostname = false
            RouteMetric = 512
          '';
        })
      {
        "0" = {};
        "1" = {};
        "2" = {};
        "3" = {};
      };
    services.update-prefetch.enable = false;
    services.sshd.wantedBy = mkForce ["multi-user.target"];
  };

  documentation = {
    enable = false;
    nixos.options.warningsAreErrors = false;
    info.enable = false;
  };

  nix = {
    gc.automatic = true;

    settings = {
      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    nixPath = [
      "nixpkgs=${pkgs.path}"
    ];
  };

  users.extraUsers.root.openssh.authorizedKeys.keys = [
    keys.users.claude
  ];

  system.stateVersion = "23.15";
}
