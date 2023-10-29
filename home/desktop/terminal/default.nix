{lib, ...}: {
  imports = [
    ./alacritty.nix
    ./atuin
    ./kitty
  ];

  options.my.home.terminal = with lib; {
    enable = mkEnableOption "terminal configuration";
  };
}
