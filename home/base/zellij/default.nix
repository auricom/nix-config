{
  config,
  lib,
  ...
}: let
  cfg = config.my.home.zellij;
  fish = config.my.home.fish;
  nushell = config.my.home.nushell;
in {
  options.my.home.zellij = with lib; {
    enable = my.mkDisableOption "zellij configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
    };

    programs = {
      fish.interactiveShellInit = lib.mkIf fish.enable ''eval (zellij setup --generate-auto-start fish | string collect)'';

      nushell.extraConfig = lib.mkIf fish.enable ''use ${nushell-scripts}/custom-completions/zellij/zellij-completions.nu *'';
    };

    home.sessionVariables = {
      # ZELLIJ_AUTO_ATTACH = "false";
      ZELLIJ_AUTO_EXIT = "true";
    };

    xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  };
}
