{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.gtk;
in
{
  options.my.home.gtk = with lib; {
    enable = mkEnableOption "GTK configuration";
  };

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;

      font = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      gtk2 = {
        # That sweet, sweet clean home that I am always aiming for...
        configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      };

      iconTheme = {
        package = pkgs.catppuccin-papirus-folders;
        name = "Papirus-Dark";
      };

      theme = {
        name = "Catppuccin-Macchiato-Standard-Sapphire-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "sapphire" ];
          variant = "macchiato";
        };
      };
    };

    home.packages = with pkgs; [
      gnome.gnome-tweaks
      gnomeExtensions.gtile
      gnomeExtensions.tray-icons-reloaded
      gnomeExtensions.user-themes
      gnomeExtensions.vitals
    ];
  };
}