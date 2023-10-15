{
  description = "Auricom Nix configuration";

  inputs = {
    agenix = {
      type = "github";
      owner = "ryantm";
      repo = "agenix";
      ref = "main";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      ref = "main";
      inputs = {
        nixpkgs-lib.follows = "nixpkgs";
      };
    };

    futils = {
      type = "github";
      owner = "numtide";
      repo = "flake-utils";
      ref = "main";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    nur = {
      type = "github";
      owner = "nix-community";
      repo = "NUR";
      ref = "master";
    };

    pre-commit-hooks = {
      type = "github";
      owner = "cachix";
      repo = "pre-commit-hooks.nix";
      ref = "master";
      inputs = {
        flake-utils.follows = "futils";
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
      };
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # useful nushell scripts, such as auto_completion
    nushell-scripts = {
      url = "github:nushell/nu_scripts";
      flake = false;
    };

    disko = {
      url = "github:nix-community/disko";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # TODO
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
    };

    talhelper = {
      url = "github:budimanjojo/talhelper";
    };

    # catppuccin
    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };

    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };

    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };

    catppuccin-helix = {
      url = "github:catppuccin/helix";
      flake = false;
    };

    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };

    catppuccin-k9s = {
      url = "github:catppuccin/k9s";
      flake = false;
    };

    catppuccin-fish = {
      url = "github:catppuccin/fish";
      flake = false;
    };

    catppuccin-hyprland = {
      url = "github:catppuccin/hyprland";
      flake = false;
    };
  };

  outputs = inputs: import ./flake inputs;
}
