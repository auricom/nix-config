# User setup
{
  config,
  lib,
  pkgs,
  ...
}: let
  secrets = config.age.secrets;
  cfg = config.my.system.users;
  groupExists = grp: builtins.hasAttr grp config.users.groups;
  groupsIfExist = builtins.filter groupExists;
in {
  options.my.system.users = with lib; {
    enable = my.mkDisableOption "user configuration";
  };

  config = lib.mkIf cfg.enable {
    users = {
      mutableUsers = false;

      users = {
        root = {
          hashedPasswordFile = secrets."users/root/hashed-password".path;
        };

        ${config.my.user.name} = {
          hashedPasswordFile = secrets."users/claude/hashed-password".path;
          description = "Claude";
          isNormalUser = true;
          shell = pkgs.fish;
          extraGroups = groupsIfExist [
            "audio" # sound control
            "docker"
            "media" # access to media files
            "networkmanager" # wireless configuration
            "plugdev" # usage of ZSA keyboard tools
            "podman" # usage of `podman` socket
            "vboxusers" # Virtualbox
            "video" # screen control
            "wheel" # `sudo` for the user.
          ];
        };
      };
    };

    security.sudo.extraRules = [
      {
        users = [config.my.user.name];
        commands = [
          {
            command = "ALL";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };
}
