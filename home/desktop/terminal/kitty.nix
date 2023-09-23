{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.kitty;
in
{
  options.my.home.kitty = with lib; {
    enable = mkEnableOption "kitty configuration";
  };

  config = lib.mkIf cfg.enable {

    programs.kitty = {
      enable = true;
      # kitty has catppuccin theme built-in,
      # all the built-in themes are packaged into an extra package named `kitty-themes`
      # and it's installed by home-manager if `theme` is specified.
      theme = "Catppuccin-Frappe";
      font = {
        name = "FiraCode Nerd Font";
        size = 13;
      };

      keybindings = {
        "ctrl+shift+m" = "toggle_maximized";
      };

      settings = {
        background_opacity = "0.93";
        scrollback_lines = 10000;
        enable_audio_bell = false;
        tab_bar_edge = "top";     # tab bar on top
      };
    };
  };
}