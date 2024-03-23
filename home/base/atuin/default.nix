{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  fish = config.my.home.fish;
  nushell = config.my.home.nushell;
in {
  config = {
    home.packages = with pkgs; [
      inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.atuin
    ];

    programs.fish = lib.mkIf fish.enable {
      interactiveShellInit = "atuin init fish --disable-up-arrow | source";
    };

    home.file.".local/share/atuin/init.nu".source = lib.mkIf nushell.enable ./init.nu;
  };
}
