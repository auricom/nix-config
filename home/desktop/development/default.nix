{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.development;
in
{
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
      pgcli
      pre-commit
      sops
      yq-go

      # python
      python311Packages.virtualenv
    ];
  };
}