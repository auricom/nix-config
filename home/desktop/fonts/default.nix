{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.fonts;
in
{
  options.my.home.fonts = with lib; {
    enable = mkEnableOption "fonts configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # icon fonts
      font-awesome
      material-design-icons
      # nerdfonts
      meslo-lgs-nf
      (nerdfonts.override { fonts = [ "FiraCode" "Ubuntu" "UbuntuMono" ]; })
    ];

    # allow fontconfig to discover fonts and configurations installed through home.packages
    fonts.fontconfig.enable = true;
  };

}