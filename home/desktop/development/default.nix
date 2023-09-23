{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.development;
in
{
  imports = [
    ./git.nix
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
      # TODO unstable.python3Packages.pip
      # TODO unstable.python3Packages.setuptools
      # TODO unstable.python3Packages.virtualenvwrapper
      vscodium
      yq-go
      
      # python
      pipenv
    ];
  };
}