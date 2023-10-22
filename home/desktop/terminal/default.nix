{lib, ...}: {
  imports = [
    ./alacritty.nix
    ./kitty
  ];

  options.my.home.terminal = with lib; {
    enable = mkEnableOption "terminal configuration";
  };
}
