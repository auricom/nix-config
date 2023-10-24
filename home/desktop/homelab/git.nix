{
  config,
  lib,
  ...
}: let
  cfg = config.my.home.homelab;
in {
  config.programs.git = lib.mkIf cfg.enable {
    # Who am I?
    userEmail = "27022259+auricom@users.noreply.github.com";
    userName = "auricom";
    extraConfig.user.signingkey = "/home/claude/.ssh/id_ed25519";
  };
}
