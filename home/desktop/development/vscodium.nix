{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.development;
  inputs.catppuccin-vsc.url = "github.com:catppuccin/vscode";
  jsonFormat = pkgs.formats.json { };
  nixpkgs.overlays = [inputs.catppuccin-vsc.overlays.default];
in
{
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      # enableExtensionUpdateCheck = false;
      # enableUpdateCheck = false;
      # mutableExtensionsDir = false;

      # # Update script https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vscode/extensions/update_installed_exts.sh
      # extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      #   {
      #     name = "catppuccin-vsc";
      #     publisher = "Catppuccin";
      #     version = "3.3.0";
      #     sha256 = "0i4wwf0q932l8h6pjdxa9d53m6ih8lyh21lp4dalq71rlf87nfj9";
      #   }
      #   {
      #     name = "catppuccin-vsc-icons";
      #     publisher = "Catppuccin";
      #     version = "0.28.0";
      #     sha256 = "1jcvrxs1c3rgwmrinbmgspb3d8pshmz7wdins90cjrhplz906g1h";
      #   }
      #   {
      #     name = "gitlens";
      #     publisher = "eamodio";
      #     version = "2023.9.2605";
      #     sha256 = "1541p7iy6f2x9w9gx5dvl35balwns75ls8kylp4h4h0399y5pfpm";
      #   }
      #   {
      #     name = "EditorConfig";
      #     publisher = "EditorConfig";
      #     version = "0.16.4";
      #     sha256 = "0fa4h9hk1xq6j3zfxvf483sbb4bd17fjl5cdm3rll7z9kaigdqwg";
      #   }
      #   {
      #     name = "nix-ide";
      #     publisher = "jnoortheen";
      #     version = "0.2.2";
      #     sha256 = "1264027sjh9a112si0y0p3pk3y36shj5b4qkpsj207z7lbxqq0wg";
      #   }
      #   {
      #     name = "ecdc";
      #     publisher = "mitchdenny";
      #     version = "1.8.0";
      #     sha256 = "11gc4qgqypbrcj33m4lx4xkcj8z7a41rby28iq091rj206gaarav";
      #   }
      #   {
      #     name = "vscode-kubernetes-tools";
      #     publisher = "ms-kubernetes-tools";
      #     version = "1.3.14";
      #     sha256 = "06lq8w87wp7msxc7mj0xiya60wy0fh3pdsh30lp34vgqsxj30n8j";
      #   }
      #   {
      #     name = "python";
      #     publisher = "ms-python";
      #     version = "2023.17.12692049";
      #     sha256 = "00qdnyzsd1a20w2fg9p5vdikgkvv23rkkn7kg57f59lz640pqjng";
      #   }
      #   {
      #     name = "indent-rainbow";
      #     publisher = "oderwat";
      #     version = "8.3.1";
      #     sha256 = "0iwd6y2x2nx52hd3bsav3rrhr7dnl4n79ln09picmnh1mp4rrs3l";
      #   }
      #   {
      #     name = "ansible";
      #     publisher = "redhat";
      #     version = "2.7.98";
      #     sha256 = "0bl7bzcz77fm9i6n8wgw3qqflir6lpry7h32icfdcvlhhz87hxkg";
      #   }
      #   {
      #     name = "vscode-yaml";
      #     publisher = "redhat";
      #     version = "1.14.0";
      #     sha256 = "0pww9qndd2vsizsibjsvscz9fbfx8srrj67x4vhmwr581q674944";
      #   }
      #   {
      #     name = "gitmoji-vscode";
      #     publisher = "seatonjiang";
      #     version = "1.2.4";
      #     sha256 = "00wlx4zisrj1mlf403lakbcy0clmfwkyq5m3dn09470pysqhcsjc";
      #   }
      #   {
      #     name = "trailing-spaces";
      #     publisher = "shardulm94";
      #     version = "0.4.1";
      #     sha256 = "15i1xcd7p6xfb8kj90irznf4xw48mmwzc528zrk3kiniy9nkbcd4";
      #   }
      #   {
      #     name = "signageos-vscode-sops";
      #     publisher = "signageos";
      #     version = "0.8.0";
      #     sha256 = "1mjvlv3yr2ilyki5ydj8kn851rr1lmf05rm9rkv8dihhyqmdpiid";
      #   }
      # ];

      # userSettings = {
      #   "workbench.iconTheme" = "catppuccin-macchiato";
      #   "workbench.colorTheme" = "Catppuccin Macchiato";

      #   "nix.enableLanguageServer" = true;
      #   "nix.serverPath" = "nil";
      #   "nix.formatterPath" = "nixpkgs-fmt";
      #   "nix.serverSettings" = {
      #     "nil" = {
      #       "formatting" = { "command" = [ "nixpkgs-fmt" ]; };
      #     };
      #   };

      #   "git.enableSmartCommit" = true;

      #   "editor.fontFamily" = "FiraCode Nerd Font";
      #   "editor.fontLigatures" = true;
      #   "editor.bracketPairColorization.enabled" = true;
      #   "editor.stickyScroll.enabled" = true;
      #   "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
      #   "terminal.integrated.fontSize" = 12;

      #   "files.associations" = {
      #     "*.json5" = "jsonc";
      #   };
      # };
    };
  };
}