{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.my.home.btop;
  catppuccin-btop = inputs.catppuccin-btop;
in {
  options.my.home.btop = with lib; {
    enable = my.mkDisableOption "btop configuration";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."btop/themes".source = "${inputs.nur-ryan4yin.packages."x86_64-linux".catppuccin-btop}/themes";

    # replacement of htop/nmon
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "catppuccin_macchiato";
        theme_background = false; # make btop transparent
      };
    };
  };
}
