{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.my.home.fish;
  catppuccin-fish = inputs.catppuccin-fish;
  fish-autorepair = inputs.fish-autorepair;
  fish-kubectl-completions = inputs.fish-kubectl-completions;

  plugin-fzf-rev = "refs/tags/v10.0"; # renovate: datasource=github-tags depName=PatrickF1/fzf.fish versioning=loose
  plugin-fzf-sha256 = "bad_value1"; # depName=PatrickF1/fzf.fish

  plugin-autorepair-rev = "refs/tags/1.0.2"; # renovate: datasource=github-tags depName=jorgebucaran/autopair.fish versioning=semver
  plugin-autorepair-sha256 = "bad_value2"; # depName=jorgebucaran/autopair.fish

  plugin-forgit-rev = "refs/tags/23.08.0"; # renovate: datasource=github-tags depName=wfxr/forgit versioning=semver
  plugin-forgit-sha256 = "bad_value3"; # depName=wfxr/forgit

  plugin-sponge-rev = "refs/tags/1.0.4"; # renovate: datasource=github-tags depName=meaningful-ooo/sponge versioning=semver
  plugin-sponge-sha256 = "bad_value4"; # depName=meaningful-ooo/sponge
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
        # Use git more efficiently with fzf
        # https://github.com/wfxr/forgit
        {
          name = "forgit";
          src = pkgs.fetchFromGitHub {
            owner = "wfxr";
            repo = "forgit";
            rev = "${plugin-forgit-rev}";
            sha256 = "${plugin-forgit-sha256}";
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
            rev = "ced676392575d618d8b80b3895cdc3159be3f628";
            sha256 = "sha256-OYiYTW+g71vD9NWOcX1i2/TaQfAg+c2dJZ5ohwWSDCc=";
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