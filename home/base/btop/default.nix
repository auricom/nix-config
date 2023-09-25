{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.btop;
in
{
  options.my.home.btop = with lib; {
    enable = my.mkDisableOption "btop configuration";
  };

  config = lib.mkIf cfg.enable {


    home.file.".config/btop/themes/catppuccin_mocha".text = builtins.readFile # https://github.com/catppuccin/btop/blob/main/themes/catppuccin_mocha.theme
    (pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "btop";
      rev = "89ff712eb62747491a76a7902c475007244ff202";
      sha256 = "0nf4jd8k22kyp5bscxma48rdfpq4qr5cg6jigrlxq38cwk61wx97";
    } + "/themes/catppuccin_mocha.theme");

    # replacement of htop/nmon
    programs.btop = {
      enable = true;
      settings = {
          color_theme = "catppuccin_mocha";
          theme_background = false; # make btop transparent
      };
    };
  };
}