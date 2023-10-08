{ pkgs, ... }:
{
  my.services = {
    # Enable Resilio
    resilio-sync.enable = true;
  };
}