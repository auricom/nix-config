{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.bat;
  fish = config.my.home.fish;
  nushell = config.my.home.nushell;
in
{
  options.my.home.bat = with lib; {
    enable = my.mkDisableOption "bat configuration";
  };

  config = lib.mkIf cfg.enable {

    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "Catppuccin-mocha";
      };
      themes = {

        Catppuccin-mocha = builtins.readFile # https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme
        (pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "1g2r6j33f4zys853i1c5gnwcdbwb6xv5w6pazfdslxf69904lrg9";
        } + "/Catppuccin-mocha.tmTheme");
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