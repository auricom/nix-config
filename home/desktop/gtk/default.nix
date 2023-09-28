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

      # TODO

      # cursorTheme = {
      #   name = "Catppuccin-Mocha-Lavender-Cursors";
      #   package = pkgs.catppuccin-cursors.mochaLavender;
      # };

      # iconTheme = {
      #   package = pkgs.catppuccin-papirus-folders;
      #   name = "Papirus-Dark";
      # };

      # theme = {
      #   name = "Catppuccin-Macchiato-Standard-Blue-Dark";
      #   package = pkgs.catppuccin-gtk.override {
      #     accents = [ "blue" ];
      #     variant = "macchiato";
      #   };
      # };

      # gtk3.extraConfig = {
      #   Settings = ''
      #     gtk-application-prefer-dark-theme=1
      #   '';
      # };

      # gtk4.extraConfig = {
      #   Settings = ''
      #     gtk-application-prefer-dark-theme=1
      #   '';
      # };
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