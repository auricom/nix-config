{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.my.home.starship;
in {
  options.my.home.starship = with lib; {
    enable = my.mkDisableOption "starship configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;

      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;

      settings =
        {
          character = {
            success_symbol = "[›](bold green)";
            error_symbol = "[›](bold red)";
          };
          aws = {
            symbol = "  ";
          };
          battery = {
            full_symbol = "🔋";
            charging_symbol = "🔌";
            discharging_symbol = "⚡";
            display = [
              {
                threshold = 30;
                style = "bold red";
              }
            ];
          };
          cmd_duration = {
            min_time = 10000; # Show command duration over 10,000 milliseconds (=10 sec)
            format = " took [$duration]($style)";
          };
          directory = {
            read_only = " 󰌾";
          };
          docker_context = {
            symbol = " ";
          };
          git_branch = {
            symbol = " ";
          };
          golang = {
            symbol = " ";
          };
          hostname = {
            ssh_symbol = " ";
          };
          kubernetes = {
            disabled = false;
            detect_files = ["k8s"];
          };
          memory_usage = {
            symbol = "󰍛 ";
          };
          nix_shell = {
            symbol = " ";
          };
          os.symbols = {
            Fedora = " ";
            Linux = " ";
            Macos = " ";
            NixOS = " ";
            Ubuntu = " ";
            Unknown = " ";
            Windows = "󰍲 ";
          };
          package = {
            symbol = "󰏗 ";
          };
          python = {
            symbol = " ";
          };
          time = {
            disabled = false;
            format = "[$time]($style) ";
            time_format = "%T";
          };
          palette = "catppuccin_macchiato";
        }
        // builtins.fromTOML (builtins.readFile "${inputs.nur-ryan4yin.packages."x86_64-linux".catppuccin-starship}/palettes/macchiato.toml");
    };
  };
}
