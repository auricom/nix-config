{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.fish;
  catppuccin-fish = inputs.catppuccin-fish;

  plugin-autorepair-rev = "refs/tags/1.0.4"; # renovate: datasource=github-tags depName=jorgebucaran/autopair.fish versioning=semver
  plugin-autorepair-hash = "sha256-s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU="; # depName=jorgebucaran/autopair.fish

  plugin-fzf-rev = "refs/tags/v10.2"; # renovate: datasource=github-tags depName=PatrickF1/fzf.fish versioning=loose
  plugin-fzf-hash = "sha256-1/MLKkUHe4c9YLDrH+cnL+pLiSOSERbIZSM4FTG3wF0="; # depName=PatrickF1/fzf.fish

  plugin-sponge-rev = "refs/tags/1.1.0"; # renovate: datasource=github-tags depName=meaningful-ooo/sponge versioning=semver
  plugin-sponge-hash = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w="; # depName=meaningful-ooo/sponge
in {
  options.my.home.fish = with lib; {
    enable = my.mkDisableOption "fish configuration";
    # https://github.com/NixOS/nixpkgs/issues/261777
    vendor.config.enable = false;
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."fish/themes/Catppuccin Macchiato.theme".source = "${catppuccin-fish}/themes/Catppuccin Macchiato.theme";

    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        set -x LS_COLORS $(vivid generate catppuccin-macchiato)
      '';

      plugins = [
        # Auto-complete matching pairs in the Fish command line
        # https://github.com/jorgebucaran/autopair.fish
        {
          name = "autopair";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "autopair.fish";
            rev = "${plugin-autorepair-rev}";
            sha256 = "${plugin-autorepair-hash}";
          };
        }
        # Interactively find and insert file paths, git commit hashes, and other entities
        # https://github.com/PatrickF1/fzf.fish
        {
          name = "fzf";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "${plugin-fzf-rev}";
            sha256 = "${plugin-fzf-hash}";
          };
        }
        # Clean fish history from typos automatically
        # https://github.com/meaningful-ooo/sponge
        {
          name = "sponge";
          src = pkgs.fetchFromGitHub {
            owner = "meaningful-ooo";
            repo = "sponge";
            rev = "${plugin-sponge-rev}";
            sha256 = "${plugin-sponge-hash}";
          };
        }
      ];

      shellAbbrs = {
        # Nix
        hms = "home-manager switch --flake ~/repositories/nix-config";
        nrs = "nixos-rebuild switch --flake ~/repositories/nix-config --use-remote-sudo";
        nrsbug = "nixos-rebuild switch --flake ~/repositories/nix-config --use-remote-sudo --show-trace --verbose";
        nfu = "nix flake update ~/repositories/nix-config";
        nh = "nix profile history --profile /nix/var/nix/profiles/system";
        ngc = "sudo nix-collect-garbage --delete-older-than 14d";
        ngcf = "sudo nix store gc --debug";
        nso = "nix-store --optimise";
        swboot = "sudo /run/current-system/bin/switch-to-configuration boot";
      };
    };

    programs.nix-index.enableFishIntegration = true;
  };
}
