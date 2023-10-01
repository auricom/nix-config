{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.my.home.btop;
  catppuccin-btop = inputs.catppuccin-btop;
in
{
  options.my.home.btop = with lib; {
    enable = my.mkDisableOption "btop configuration";
  };

  config = lib.mkIf cfg.enable {

    xdg.configFile."btop/themes/catppuccin_macchiato".source = "${catppuccin-btop}/themes/catppuccin_macchiato.theme";

    # replacement of htop/nmon
    programs.btop = {
      enable = true;
      settings = {
          color_theme = "catppuccin_macchiato";
          theme_background = false; # make btop transparent
      };
    };
  };
}