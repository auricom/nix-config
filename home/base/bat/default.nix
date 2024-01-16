{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.my.home.bat;
  fish = config.my.home.fish;
  nushell = config.my.home.nushell;
in {
  options.my.home.bat = with lib; {
    enable = my.mkDisableOption "bat configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "Catppuccin-macchiato";
      };
      themes = {
        Catppuccin-macchiato = {
          src = inputs.nur-ryan4yin.packages."x86_64-linux".catppuccin-bat;
          file = "Catppuccin-macchiato.tmTheme";
        };
      };
    };

    home.packages = with pkgs; [
      bat-extras.batgrep
    ];

    programs.fish.shellAliases = lib.mkIf fish.enable {
      cat = "bat --pager=never";
    };

    programs.nushell.shellAliases = lib.mkIf nushell.enable {
      cat = "bat --pager=never";
    };
  };
}
