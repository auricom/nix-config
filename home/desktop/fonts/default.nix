{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.fonts;
in
{
  options.my.home.fonts = with lib; {
    enable = mkEnableOption "fonts configuration";
  };

  config.home.packages = with pkgs; [
    # icon fonts
    font-awesome
    material-design-icons
    # nerdfonts
    (nerdfonts.override {
      fonts = [
        "FiraCode"
      ];
    })
  ];
  
  config.fonts.fontconfig.enable = true;
}