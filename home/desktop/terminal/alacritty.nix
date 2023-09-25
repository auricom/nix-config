{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.alacritty;
in
{
  options.my.home.alacritty = with lib; {
    enable = mkEnableOption "alacritty configuration";
  };

  config = lib.mkIf cfg.enable {

    xdg.configFile."alacritty/theme_catppuccin.yml".text = builtins.readFile # https://raw.githubusercontent.com/catppuccin/alacritty/main/catppuccin-mocha.yml
        (pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "alacritty";
          rev = "3c808cbb4f9c87be43ba5241bc57373c793d2f17";
          sha256 = "07gvkxz9axvjjplpmwf6k0nk6n84gm20s0k5qkqsqkmv8ysdbmf3";
        } + "/catppuccin-mocha.yml");
    programs.alacritty = {
      enable = true;
    };

    xdg.configFile."alacritty/alacritty.yml".text =
      ''
        import:
          # all alacritty themes can be found at
          #    https://github.com/alacritty/alacritty-theme
          - ~/.config/alacritty/theme_catppuccin.yml

        window:
          # Background opacity
          #
          # Window opacity as a floating point number from `0.0` to `1.0`.
          # The value `0.0` is completely transparent and `1.0` is opaque.
          opacity: 0.98

          # Startup Mode (changes require restart)
          #
          # Values for `startup_mode`:
          #   - Windowed
          #   - Maximized
          #   - Fullscreen
          #
          # Values for `startup_mode` (macOS only):
          #   - SimpleFullscreen
          startup_mode: Maximized

          # Allow terminal applications to change Alacritty's window title.
          dynamic_title: true

          # Make `Option` key behave as `Alt` (macOS only):
          #   - OnlyLeft
          #   - OnlyRight
          #   - Both
          #   - None (default)
          option_as_alt: Both

        scrolling:
          # Maximum number of lines in the scrollback buffer.
          # Specifying '0' will disable scrolling.
          history: 10000

          # Scrolling distance multiplier.
          #multiplier: 3

        # Font configuration
        font:
          # Normal (roman) font face
          bold:
            family: FiraCode Nerd Font
          italic:
            family: FiraCode Nerd Font
          normal:
            family: FiraCode Nerd Font
          bold_italic:
            # Font family
            #
            # If the bold italic family is not specified, it will fall back to the
            # value specified for the normal font.
            family: FiraCode Nerd Font
      ''
    + (
      if pkgs.stdenv.isDarwin
      then ''
          # Point size
          size: 13
      ''
      else ''
        # holder identation
          # Point size
          size: 11
      ''
    );
  };
}