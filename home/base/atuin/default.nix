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

    programs = {
      fish.interactiveShellInit = lib.mkIf fish.enable "atuin init fish --disable-up-arrow | source";
      nushell.extraConfig = lib.mkIf nushell.enable ''
        source ~/.local/share/atuin/init.nu
        source ~/.local/share/atuin/autocompletion.nu
      '';
    };

    home.file.".local/share/atuin/init.nu".source = lib.mkIf nushell.enable ./init.nu;
    home.file.".local/share/atuin/autocompletion.nu".source = lib.mkIf nushell.enable ./autocompletion.nu;
  };
}
