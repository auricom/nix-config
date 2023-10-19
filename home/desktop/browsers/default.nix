{lib, ...}: {
  imports = [
    ./chromium.nix
    # ./firefox.nix
    ./librewolf.nix
  ];

  options.my.home.browsers = with lib; {
    enable = mkEnableOption "browsers configuration";
  };
}
