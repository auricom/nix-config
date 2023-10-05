{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.my.home.fish;
  catppuccin-fish = inputs.catppuccin-fish;
  fish-autorepair = inputs.fish-autorepair;
  fish-kubectl-completions = inputs.fish-kubectl-completions;

  plugin-autorepair-rev = "refs/tags/1.0.4"; # renovate: datasource=github-tags depName=jorgebucaran/autopair.fish versioning=semver
  plugin-autorepair-sha256 = "sha256-s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU="; # depName=jorgebucaran/autopair.fish

  plugin-fzf-rev = "refs/tags/v10.0"; # renovate: datasource=github-tags depName=PatrickF1/fzf.fish versioning=loose
  plugin-fzf-sha256 = "sha256-CqRSkwNqI/vdxPKrShBykh+eHQq9QIiItD6jWdZ/DSM="; # depName=PatrickF1/fzf.fish

  plugin-kubectl-rev = "ced676392575d618d8b80b3895cdc3159be3f628";
  plugin-kubectl-sha256 = "bad_33"; # depName=evanlucas/fish-kubectl-completions

  plugin-sponge-rev = "refs/tags/1.1.0"; # renovate: datasource=github-tags depName=meaningful-ooo/sponge versioning=semver
  plugin-sponge-sha256 = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w="; # depName=meaningful-ooo/sponge
in
{
  options.my.home.fish = with lib; {
    enable = my.mkDisableOption "fish configuration";
  };

  config = lib.mkIf cfg.enable {

    xdg.configFile."fish/themes/Catppuccin Macchiato.theme".source = "${catppuccin-fish}/themes/Catppuccin Macchiato.theme";

    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        set -x LS_COLORS $(vivid generate catppuccin-macchiato)
      '';

      functions = {
        git-clean = ''
            git fetch --prune
            for branch in (git branch -vv | grep ': gone]' | awk '{print $1}')
                git branch -D $branch
            end
          '';
        wip = ''
          git add -A
          git commit --amend --no-edit
          git push --force
        '';
        };

      plugins = [
        # Auto-complete matching pairs in the Fish command line
        # https://github.com/jorgebucaran/autopair.fish
        {
          name = "autopair";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "autopair.fish";
            rev = "${plugin-autorepair-rev}";
            sha256 = "${plugin-autorepair-sha256}";
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
            sha256 = "${plugin-fzf-sha256}";
          };
        }
        # kubectl completions for fish shell
        # https://github.com/evanlucas/fish-kubectl-completions
        {
          name = "kubectl-completions";
          src = pkgs.fetchFromGitHub {
            owner = "evanlucas";
            repo = "fish-kubectl-completions";
            rev = "${plugin-kubectl-rev}";
            sha256 = "${plugin-kubectl-sha256}";
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
            sha256 = "${plugin-sponge-sha256}";
          };
        }
      ];

      shellAbbrs = {
        # Nix
        nrs = "nixos-rebuild switch --flake ~/repositories/nix-config --use-remote-sudo";
        nrsbug = "nixos-rebuild switch --flake ~/repositories/nix-config --use-remote-sudo --show-trace --verbose";
        nfu = "nix flake update ~/repositories/nix-config";
        nh = "nix profile history --profile /nix/var/nix/profiles/system";
        ngc = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d";
        ngcf = "sudo nix store gc --debug";
      };
    };
  };
}