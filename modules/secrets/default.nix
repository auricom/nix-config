{ config, inputs, lib, self, ... }:

{
  imports = [
    inputs.agenix.nixosModules.age
    inputs.agenix-rekey.nixosModules.default
  ];

  config = {
    age = {
      secrets =
        let
          toName = lib.removeSuffix ".age";
          userExists = u: builtins.hasAttr u config.users.users;
          # Only set the user if it exists, to avoid warnings
          userIfExists = u: if userExists u then u else "root";
          toSecret = name: { owner ? "root", ... }: {
            file = ./. + "/${name}";
            owner = lib.mkDefault (userIfExists owner);
          };
          convertSecrets = n: v: lib.nameValuePair (toName n) (toSecret n v);
          secrets = import ./secrets.nix;
        in
        lib.mapAttrs' convertSecrets secrets;
      identityPaths = [
        /etc/agenix/identity
      ];
    };

    agenix-rekey = inputs.agenix-rekey.configure {
      userFlake = self;
      nodes = self.nixosConfigurations;
      # Example for colmena:
      # inherit ((colmena.lib.makeHive self.colmena).introspect (x: x)) nodes;
    };
  };
}
