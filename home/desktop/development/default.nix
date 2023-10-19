{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.development;
in {
  imports = [
    ./git
    ./vscodium.nix
  ];

  options.my.home.development = with lib; {
    enable = mkEnableOption "development configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      age
      gh
      jq
      just
      pgcli
      pre-commit
      sops
      treefmt
      yq-go

      # python
      python311Packages.virtualenv

      # formaters
      deadnix
      rustup
      inputs.alejandra.defaultPackage.x86_64-linux
    ];
  };
}
