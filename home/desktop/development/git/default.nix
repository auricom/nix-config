{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.my.home.development;
  fish = config.my.home.fish;
  nushell = config.my.home.nushell;

  plugin-breeze-rev = "7a4cd0abaf754a535155ff4ef24a169fc7c9b758";
  plugin-breeze-hash = "sha256-efjpQebYhqXZHalmxGH2J0f080SZBSOMaLdt3Xz5dNs=";
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      cocogitto
      git-absorb
      git-revise
      tig
    ];

    programs = {
      git = {
        enable = true;

        # I want the full experience
        package = pkgs.gitFull;

        lfs.enable = true;

        delta = {
          enable = true;

          options = {
            features = "diff-highlight decorations";

            # Less jarring style for `diff-highlight` emulation
            diff-highlight = {
              minus-style = "red";
              minus-non-emph-style = "red";
              minus-emph-style = "bold red 52";

              plus-style = "green";
              plus-non-emph-style = "green";
              plus-emph-style = "bold green 22";

              whitespace-error-style = "reverse red";
            };

            # Personal preference for easier reading
            decorations = {
              commit-style = "raw"; # Do not recolor meta information
              keep-plus-minus-markers = true;
              paging = "always";
            };
          };
        };

        extraConfig = {
          # Makes it a bit more readable
          blame = {
            coloring = "repeatedLines";
            markIgnoredLines = true;
            markUnblamables = true;
          };

          # I want `pull --rebase` as a default
          branch = {
            autosetubrebase = "always";
          };

          # Shiny colors
          color = {
            branch = "auto";
            diff = "auto";
            interactive = "auto";
            status = "auto";
            ui = "auto";
          };

          # Pretty much the usual diff colors
          "color.diff" = {
            commit = "yellow";
            frag = "cyan";
            meta = "yellow";
            new = "green";
            old = "red";
            whitespace = "red reverse";
          };

          commit = {
            gpgSign = true;
            # Show my changes when writing the message
            verbose = true;
          };

          core = {
            editor = "codium --wait";
          };

          diff = {
            # Usually leads to better results
            algorithm = "patience";
            # Use better, descriptive initials (c, i, w) instead of a/b.
            mnemonicPrefix = true;
            # Display submodule-related information (commit listings)
            submodule = "log";
            # When using --word-diff, assume --word-diff-regex=.
            wordRegex = ".";
          };

          fetch = {
            # I don't want hanging references
            prune = true;
            pruneTags = true;
          };

          gpg = {
            format = "ssh";
          };

          init = {
            defaultBranch = "main";
          };

          # Local configuration, not-versioned
          include = {
            path = "config.local";
          };

          merge = {
            conflictStyle = "zdiff3";
          };

          mergetool = {
            # Clean up backup files created by merge tools on tool exit
            keepBackup = false;
            # Clean up temp files created by merge tools on tool exit
            keepTemporaries = false;
            # Auto-accept file prompts when launching merge tools
            prompt = false;
            # Put the temp files in a dedicated dir anyway
            writeToTemp = true;
          };

          pull = {
            # Avoid useless merge commits
            rebase = "merges";
          };

          push = {
            autoSetupRemote = true;
            default = "upstream";
            followTags = true;
          };

          rebase = {
            # Why isn't it the default?...
            autoSquash = true;
            autoStash = true;
          };

          status = {
            # Display submodule rev change summaries in status
            submoduleSummary = true;
          };

          tag = {
            sort = "version:refname";
          };

          url = {
            "git@github.com:" = {
              insteadOf = "https://github.com/";
            };

            "git@gitlab.com:" = {
              insteadOf = "https://gitlab.com/";
            };
          };
        };

        ignores = let
          inherit (builtins) readFile;
          inherit (lib) filter hasPrefix splitString;
          readLines = file: splitString "\n" (readFile file);
          removeComments = filter (line: line != "" && !(hasPrefix "#" line));
          getPaths = file: removeComments (readLines file);
        in
          getPaths ./default.ignore;
      };

      fish = {
        plugins = [
          # breeze
          # https://github.com/shinriyo/breeze
          {
            name = "breeze";
            src = pkgs.fetchFromGitHub {
              owner = "shinriyo";
              repo = "breeze";
              rev = "${plugin-breeze-rev}";
              sha256 = "${plugin-breeze-hash}";
            };
          }
        ];

        shellAbbrs = {
          glol = "git log --graph --decorate --pretty=oneline --abbrev-commit --topo-order";
          glola = "git log --graph --decorate --pretty=oneline --abbrev-commit --topo-order --all";
        };
      };

      nushell.shellAliases = lib.mkIf nushell.enable {
        glol = "git log --graph --decorate --pretty=oneline --abbrev-commit --topo-order";
        glola = "git log --graph --decorate --pretty=oneline --abbrev-commit --topo-order --all";
      };
    };
  };
}
