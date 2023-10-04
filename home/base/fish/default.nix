{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.my.home.fish;
  catppuccin-fish = inputs.catppuccin-fish;
  fish-autorepair = inputs.fish-autorepair;
  fish-kubectl-completions = inputs.fish-kubectl-completions;

  plugin-fzf-rev = "refs/tags/v10.0"; # renovate: datasource=github-tags depName=PatrickF1/fzf.fish versioning=loose
  plugin-fzf-sha256 = "bad_value"; # depName=PatrickF1/fzf.fish
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
            rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
            sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
          };
        }
        # Use git more efficiently with fzf
        # https://github.com/wfxr/forgit
        {
          name = "forgit";
          src = pkgs.fetchFromGitHub {
            owner = "wfxr";
            repo = "forgit";
            rev = "48e91dadb53f7ac33cab238fb761b18630b6da6e";
            sha256 = "sha256-WvJxjEzF3vi+YPVSH3QdDyp3oxNypMoB71TAJ7D8hOQ=";
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
            repo = "fish-sponge";
            rev = "384299545104d5256648cee9d8b117aaa9a6d7be";
            sha256 = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
          };
        }
        # z tracks the directories you visit. With a combination of frequency and recency, it enables you to jump to the directory in mind.
        # https://github.com/jethrokuan/z
        {
          name = "z";
          src = pkgs.fetchFromGitHub {
            owner = "jethrokuan";
            repo = "z";
            rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
            sha256 = "sha256-+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
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