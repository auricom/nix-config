{
  self,
  inputs,
  ...
}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: let
    inherit (inputs) nixos-generators;

    defaultModule = {...}: {
      imports = [
        inputs.disko.nixosModules.disko
        ../generators/iso-base.nix
      ];
      _module.args.self = self;
      _module.args.inputs = inputs;
    };
  in {
    packages = {
      claude-laptop-image = nixos-generators.nixosGenerate {
        inherit pkgs;
        format = "install-iso";
        modules = [
          defaultModule
        ];
      };
    };
  };
}
