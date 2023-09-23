{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.starship;
in
{
  options.my.home.starship = with lib; {
    enable = my.mkDisableOption "starship configuration";
  };

  config = lib.mkIf cfg.enable {

    programs.starship = {
      enable = true;

      enableBashIntegration = true;
      enableFishIntegration = true;
      
      settings = {
        character = {
          error_symbol = "[✖](bold red) ";
          success_symbol = "[›](bold green)";
        };
        aws = {
          format = "on [$symbol$profile]($style) ";
          symbol = "🅰 ";
        };
        battery = {
          full_symbol = "🔋";
          charging_symbol = "🔌";
          discharging_symbol = "⚡";
        };
        battery.display = {
          threshold = 30;
          style = "bold red";
        };
        cmd_duration = {
          min_time = 10000; # Show command duration over 10,000 milliseconds (=10 sec)
          format = " took [$duration]($style)";
        };
        directory = {
          read_only = "🔒";
          read_only_style= "bold white";
        };
        docker_context = {
          format = "via [🐋 $context](blue bold)";
        };
        git_commit = {
          commit_hash_length = 8;
          style= "bold white";
        };
        git_state = {
          format = "[\($state( $progress_current of $progress_total)\)]($style) ";
        };
        git_status = {
          style = "fg:#E29191";
        };
        hostname = {
          ssh_only = true;
          disabled = false;
        };
        python = {
          symbol = " ";
          pyenv_version_name= true;
        };
        time = {
          time_format = "%T";
          format = "🕙 [$time]($style) ";
          disabled = false;
        };
        username = {
          style_user = "bold dimmed blue";
          show_always = false;
        };
        palette = "catppuccin_frappe";
      } // builtins.fromTOML (builtins.readFile # https://raw.githubusercontent.com/catppuccin/starship/main/palettes/frappe.toml
        (pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "starship";
          rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
          sha256 = "1bdm1vzapbpnwjby51dys5ayijldq05mw4wf20r0jvaa072nxi4y";
        } + "/palettes/frappe.toml"));
    };
  };
}