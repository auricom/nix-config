{inputs, ...}: {
  imports = [
    inputs.pre-commit-hooks.flakeModule
  ];

  perSystem = {...}: {
    pre-commit = {
      # Add itself to `nix flake check`
      check.enable = true;

      settings = {
        hooks = {
          alejandra = {
            enable = true;
          };

          deadnix = {
            enable = true;
          };

          shellcheck = {
            enable = true;
          };

          stylua = {
            enable = true;
          };
        };
      };
    };
  };
}
