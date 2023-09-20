{ pkgs, ... }:
{
  my.home = {
    # Machine specific packages
    packages.additionalPackages = with pkgs; [
    ];
  };
}