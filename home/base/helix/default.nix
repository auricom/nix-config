{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.packages;
in {
  config = lib.mkIf cfg.enable {
    xdg.configFile."helix/themes".source = "${inputs.nur-ryan4yin.packages."x86_64-linux".catppuccin-helix}/themes/default";

    programs.helix = {
      enable = true;
      package = pkgs.helix;
      settings = {
        theme = "catppuccin_macchiato";
        editor = {
          line-number = "relative";
          cursorline = true;
          color-modes = true;
          lsp.display-messages = true;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          indent-guides.render = true;
        };
        keys.normal = {
          space.space = "file_picker";
          space.w = ":w";
          space.q = ":q";
          esc = ["collapse_selection" "keep_primary_selection"];
        };
      };
    };
  };
}
