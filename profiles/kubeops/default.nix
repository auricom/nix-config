{
  config,
  lib,
  ...
}: let
  cfg = config.my.profiles.kubeops;
in {
  options.my.profiles.kubeops = with lib; {
    enable = mkEnableOption "kubeops profile";
  };

  config = lib.mkIf cfg.enable {
    # Enable development programs.
    my.home.development.enable = true;
    # Enable docker
    my.system.docker.enable = true;
    # Enable Kubernetes clients.
    my.home.kubernetes-client.enable = true;
    # Enable podman
    # my.system.podman.enable = true;
  };
}
