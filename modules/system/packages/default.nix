# Common packages
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.system.packages;
in {
  options.my.system.packages = with lib; {
    enable = my.mkDisableOption "packages configuration";

    allowAliases = mkEnableOption "allow package aliases";

    allowUnfree = my.mkDisableOption "allow unfree packages";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim
      wget
    ];

    programs = {
      vim.defaultEditor = true; # Modal editing is life

      fish = {
        enable = true; # Use integrations
      };
    };

    nixpkgs.config = {
      inherit (cfg) allowAliases allowUnfree;
    };
  };
}
