{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.aws-cli;
in {
  options.my.home.aws-cli = with lib; {
    enable = mkEnableOption "aws-cli configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      aws-cli
    ];
  };
}
