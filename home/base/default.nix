{config, ...}: {
  imports = [
    ./atuin
    ./bat
    ./btop
    ./helix
    ./lsd
    ./neovim
    ./packages
    ./shell
    ./starship
    # ./zellij
    ./zoxide
  ];

  config.programs.nix-index.enable = true;
}
