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
        package = pkgs.inter;
        name = "Inter";
      };

      cursorTheme = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
      };

      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

      iconTheme = {
        package = pkgs.catppuccin-papirus-folders;
        name = "Papirus-Dark";
      };

      theme = {
        # https://github.com/catppuccin/gtk
        name = "Catppuccin-Macchiato-Compact-Pink-dark";
        package = pkgs.catppuccin-gtk.override {
          # https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/data/themes/catppuccin-gtk/default.nix
          accents = [ "blue" ];
          size = "standard";
          variant = "mocha";
        };
      };
    };

    home.packages = with pkgs; [
      gnome.gnome-tweaks
      gnomeExtensions.gtile
      gnomeExtensions.tray-icons-reloaded
      gnomeExtensions.user-themes
      gnomeExtensions.vitals
      gtk-engine-murrine
    ];
  };
}