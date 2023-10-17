{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.gtk;

  catppuccin_dark_name = "Catppuccin-Mocha-Standard-Blue-Dark";
  # https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/data/themes/catppuccin-gtk/default.nix
  catppucin_dark_package = pkgs.catppuccin-gtk.override {
    accents = [ "blue" ];
    size = "standard";
    tweaks = [ "normal" ];
    variant = "mocha";
  };
  catppuccin_light_name = "Catppuccin-Latte-Standard-Blue-Light";
  catppuccin_light_package = pkgs.catppuccin-gtk.override {
    accents = [ "blue" ];
    size = "standard";
    tweaks = [ "normal" ];
    variant = "latte";
  };
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

      gtk3.extraConfig.Settings = "gtk-application-prefer-dark-theme=1";

      gtk4.extraConfig.Settings = "gtk-application-prefer-dark-theme=1";

      iconTheme = {
        package = pkgs.catppuccin-papirus-folders;
        name = "Papirus-Dark";
      };

      theme = {
        # https://github.com/catppuccin/gtk
        name = catppuccin_dark_name;
        package = catppucin_dark_package;
      };
    };

    home.file.".config/gtk-4.0/gtk.css".source = "${catppuccin_light_package}/share/themes/${catppuccin_light_name}/gtk-4.0/gtk.css";
    home.file.".config/gtk-4.0/gtk-dark.css".source = "${catppucin_dark_package}/share/themes/${catppuccin_dark_name}/gtk-4.0/gtk-dark.css";

    home.file.".config/gtk-4.0/assets" = {
      recursive = true;
      source = "${catppucin_dark_package}/share/themes/${catppuccin_dark_name}/gtk-4.0/assets";
    };

    home.packages = with pkgs; [
      gnome.gnome-tweaks
      gnomeExtensions.gtile
      gnomeExtensions.tray-icons-reloaded
      gnomeExtensions.user-themes
      gnomeExtensions.vitals
    ];

    # home.sessionVariables.GTK_THEME = "Catppuccin-Macchiato-Standard-Blue-dark";

    # Use `dconf watch /` to track stateful changes you are doing, then set them here.
    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "Vitals@CoreCoding.com"
          "trayIconsReloaded@selfmade.pl"
          "gTile@vibou"
        ];

        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "Alacritty.desktop"
          "codium.desktop"
          "librewolf.desktop"
          "1password.desktop"
        ];
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = catppuccin_dark_name;
      };
    };
  };
}