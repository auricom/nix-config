{lib, ...}: {
  imports = [
    ./alacritty.nix
    ./kitty.nix
  ];

  options.my.home.terminal = with lib; {
    enable = mkEnableOption "terminal configuration";
  };
}
