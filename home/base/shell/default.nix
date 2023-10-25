{lib, ...}: {
  imports = [
    ./fish.nix
    ./nushell
  ];

  options.my.home.browsers = with lib; {
    enable = mkEnableOption "browsers configuration";
  };
}
