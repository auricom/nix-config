{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.my.home.nushell;

  nushell-scripts = inputs.nushell-scripts;
in {
  options.my.home.nushell = with lib; {
    enable = my.mkDisableOption "nushell configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.nushell = {
      enable = true;
      package = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.nushell;
      configFile.source = ./config.nu;

      shellAliases = {
        vi = "nvim";
        vim = "nvim";
      };

      # currently, nushell does not support conditional sourcing of files
      # https://github.com/nushell/nushell/issues/8214
      extraConfig = ''
        use ${nushell-scripts}/custom-completions/nix/nix-completions.nu *
        use ${nushell-scripts}/custom-completions/npm/npm-completions.nu *
      '';
    };
  };
}
