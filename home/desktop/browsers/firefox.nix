{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.browsers;
  media.enable = config.my.home.media.enable;
  # wayland = config.my.profiles.wayland;
in {
  config.programs.firefox = lib.mkIf cfg.enable {
    enable = true;

    package = pkgs.firefox.override {
      extraNativeMessagingHosts = with pkgs; (
        []
        # Watch videos using mpv
        ++ lib.optional media.enable auricom.ff2mpv-go
      );
    };

    # profiles = {
    #   default = {
    #     id = 0;
    #     isDefault = true;
    #     name = "Default";

    #     # extensions = with pkgs.nur.repos.rycee.firefox-addons; ([
    #     #   onepassword-password-manager
    #     #   consent-o-matic
    #     #   form-history-control
    #     #   linkding-extension
    #     #   refined-github
    #     #   sponsorblock
    #     #   ublock-origin
    #     # ] ++ lib.mkIf (media.enable) ff2mpv);

    #     settings = {
    #       "browser.bookmarks.showMobileBookmarks" = true; # Mobile bookmarks
    #       "browser.download.useDownloadDir" = false; # Ask for download location
    #       "browser.in-content.dark-mode" = true; # Dark mode
    #       "browser.newtabpage.activity-stream.feeds.section.topstories" = false; # Disable top stories
    #       "browser.newtabpage.activity-stream.feeds.sections" = false;
    #       "browser.newtabpage.activity-stream.feeds.system.topstories" = false; # Disable top stories
    #       "browser.newtabpage.activity-stream.section.highlights.includePocket" = false; # Disable pocket
    #       "extensions.pocket.enabled" = false; # Disable pocket
    #       "media.eme.enabled" = true; # Enable DRM
    #       "media.gmp-widevinecdm.enabled" = true; # Enable DRM
    #       "media.gmp-widevinecdm.visible" = true; # Enable DRM
    #       "signon.autofillForms" = false; # Disable built-in form-filling
    #       "signon.rememberSignons" = false; # Disable built-in password manager
    #       "ui.systemUsesDarkTheme" = true; # Dark mode
    #     };
    #   };
    # };
  };
}
