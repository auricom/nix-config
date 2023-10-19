{
  config,
  lib,
  ...
}: let
  cfg = config.my.home.zellij;
in {
  options.my.home.zellij = with lib; {
    enable = my.mkDisableOption "zellij configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
    };

    programs.fish.interactiveShellInit = ''
      eval (zellij setup --generate-auto-start fish | string collect)
    '';

    home.sessionVariables = {
      # ZELLIJ_AUTO_ATTACH = "false";
      ZELLIJ_AUTO_EXIT = "true";
    };

    xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  };
}
