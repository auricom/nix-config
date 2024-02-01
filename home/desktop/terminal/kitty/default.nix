{
  config,
  lib,
  ...
}: let
  cfg = config.my.home.terminal;
  fish = config.my.home.fish;
  nushell = config.my.home.nushell;
in {
  config = lib.mkIf cfg.enable {
    programs = {
      kitty = {
        enable = true;
        # kitty has catppuccin theme built-in,
        # all the built-in themes are packaged into an extra package named `kitty-themes`
        # and it's installed by home-manager if `theme` is specified.
        theme = "Catppuccin-Macchiato";
        font = {
          name = "FiraCode Nerd Font";
          size = 10;
        };

        keybindings = {
          "ctrl+shift+m" = "toggle_maximized";
        };

        settings = {
          background_opacity = "1";
          hide_window_decorations = true;
          scrollback_lines = 10000;
          enable_audio_bell = false;
          tab_bar_edge = "top"; # tab bar on top
          tab_bar_style = "custom";
          tab_bar_margin_width = "2";
          tab_bar_margin_height = "5 0";
          tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index}: {title}";
        };
      };

      fish.shellAliases.ssh = lib.mkIf fish.enable "kitten ssh";

      nushell.shellAliases.ssh = lib.mkIf nushell.enable "kitten ssh";
    };

    xdg.configFile."kitty/tab_bar.py".source = ./tab_bar.py;
  };
}
