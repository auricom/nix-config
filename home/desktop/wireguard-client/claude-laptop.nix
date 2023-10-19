{
  config,
  lib,
  ...
}: let
  cfg = config.my.home.wireguard-client-claude-laptop;
in {
  options.my.home.wireguard-client-claude-laptop = with lib; {
    enable = mkEnableOption "wireguard-client configuration";
  };

  config = lib.mkIf cfg.enable {
    age.secrets."wireguard/claude-laptop.conf" = {
      path = "$HOME/wg.conf";
    };
  };
}
