# Language settings
{
  config,
  lib,
  ...
}: let
  cfg = config.my.system.language;
in {
  options.my.system.language = with lib; {
    enable = my.mkDisableOption "language configuration";

    locale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      example = "fr_FR.UTF-8";
      description = "Which locale to use for the system";
    };
  };

  config = lib.mkIf cfg.enable {
    # Select internationalisation properties.
    i18n.defaultLocale = cfg.locale;
    i18n.supportedLocales = ["en_US.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8"];

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      # LC_COLLATE = "fr_FR.UTF-8";
      # LC_CTYPE = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      # LC_MESSAGES = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };
}
