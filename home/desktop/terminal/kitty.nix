{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.terminal;
in
{
  config = lib.mkIf cfg.enable {

    programs.kitty = {
      enable = true;
      # kitty has catppuccin theme built-in,
      # all the built-in themes are packaged into an extra package named `kitty-themes`
      # and it's installed by home-manager if `theme` is specified.
      theme = "Catppuccin-Mocha";
      font = {
        name = "Hack Nerd Font";
        size = 11;
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
