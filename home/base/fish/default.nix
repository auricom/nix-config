{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.fish;
in
{
  options.my.home.fish = with lib; {
    enable = my.mkDisableOption "fish configuration";
  };

  config = lib.mkIf cfg.enable {

    programs.fish = {
      enable = true;
      
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
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
            rev = "refs/tags/1.0.4";
            sha256 = "0mfx43n3ngbmyfp4a4m9a04gcgwlak6f9myx2089bhp5qkrkanmk";
          };
        }
        # Use git more efficiently with fzf
        # https://github.com/wfxr/forgit
        {
          name = "forgit";
          src = pkgs.fishPlugins.forgit;
        }
        # Interactively find and insert file paths, git commit hashes, and other entities
        # https://github.com/PatrickF1/fzf.fish
        {
          name = "fzf";
          src = pkgs.fishPlugins.fzf-fish;
        }
        # kubectl completions for fish shell
        # https://github.com/evanlucas/fish-kubectl-completions
        {
          name = "kubectl-completions";
          src = pkgs.fetchFromGitHub {
            owner = "evanlucas";
            repo = "fish-kubectl-completions";
            rev = "ced676392575d618d8b80b3895cdc3159be3f628";
            sha256 = "09qcj82qfs4y4nfwvy90y10xmx6vc9yp33nmyk1mpvx0dx6ri21r";
          };
        }
        # Clean fish history from typos automatically
        # https://github.com/meaningful-ooo/sponge
        {
          name = "sponge";
          src = pkgs.fishPlugins.sponge;
        }
        # z tracks the directories you visit. With a combination of frequency and recency, it enables you to jump to the directory in mind.
        # https://github.com/jethrokuan/z
        {
          name = "z";
          src = pkgs.fishPlugins.z;
        }
      ];

      shellAbbrs = {
        # Nix
        nd = "nixos-rebuild switch --flake . --use-remote-sudo";
        nbug = "nixos-rebuild switch --flake . --use-remote-sudo --show-trace --verbose";
        nu = "nix flake update";
        nh = "nix profile history --profile /nix/var/nix/profiles/system";
        ngc = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d";
        ngcf = "sudo nix store gc --debug";
      };

      shellAliases = {
        k = "kubectl";
        l = "lsd -alh";
        ls = "lsd";
        ll = "lsd -l";
        cat = "bat --pager=never";
        vi = "nvim";
        vim = "nvim";
      };
    };
  };
}