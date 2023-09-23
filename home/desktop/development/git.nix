{ config, pkgs, lib, ... }:
let
  cfg = config.my.home.development;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; lib.mkIf cfg.enable [
      git-absorb
      git-revise
      tig
    ];

  programs.git =  {
    enable = true;
    
    # Who am I?
    userEmail = "27022259+auricom@users.noreply.github.com";
    userName = "auricom";

    # I want the full experience
    package = pkgs.gitFull;

    aliases = {
      git = "!git";
      lol = "log --graph --decorate --pretty=oneline --abbrev-commit --topo-order";
      lola = "lol --all";
      assume = "update-index --assume-unchanged";
      unassume = "update-index --no-assume-unchanged";
      assumed = "!git ls-files -v | grep ^h | cut -c 3-";
      pick = "log -p -G";
      push-new = "!git push -u origin "
        + ''"$(git branch | grep '^* ' | cut -f2- -d' ')"'';
      root = "git rev-parse --show-toplevel";
    };

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
      
      user = {
        signingkey = "/home/claude/.ssh/id_ed25519";
      };
    };

    ignores =
      let
        inherit (builtins) readFile;
        inherit (lib) filter hasPrefix splitString;
        readLines = file: splitString "\n" (readFile file);
        removeComments = filter (line: line != "" && !(hasPrefix "#" line));
        getPaths = file: removeComments (readLines file);
      in
      getPaths ./default.ignore;
    };

    # Fish abbreviations
    programs.fish = {
      shellAbbrs = {
        gd = "git diff -M";
        ga = "git add";
        gaa = "git add --all .";
        gbd = "git branch -D";
        gs = "git status";
        gca = "git commit -a -m";
        gm = "git merge --no-ff";
        gpt = "git push --tags";
        gp = "git push";
        grh = "git reset --hard";
        gb = "git branch";
        gcob = "git checkout -b";
        gco = "git checkout";
        gba = "git branch -a";
        gcp = "git cherry-pick";
        gl = "git log --pretty=format:\"%Cgreen%h%Creset - %Cblue%an%Creset @ %ar : %s\"";
        gl2 = "git log --pretty='format:%Cgreen%h%Creset %an - %s' --graph";
        glv = "git log --stat";
        gpom = "git pull origin master";
        gcd = "cd \"`git rev-parse --show-toplevel`\"";
      };
    };
  };
}