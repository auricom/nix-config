# Default home-manager configuration
{pkgs, ...}: let
  myUserName = "cdiarra";
in {
  home.username = myUserName;
  home.homeDirectory = "/${
    if pkgs.stdenv.isDarwin
    then "Users"
    else "home"
  }/${myUserName}";
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  my.home = {
    aws-cli.enable = false;
    development.enable = true;
    fonts.enable = true;
    gtk.enable = true;
    kubernetes-client.enable = true;
    productivity.enable = true;
    terminal.enable = true;
    utils.enable = true;
    x.enable = true;
  };
  programs = {
    git = {
      userEmail = "claude.diarra@ledger.fr";
      userName = "Claude DIARRA";
      extraConfig.user.signingkey = "/home/${myUserName}/.ssh/ldgid_ed25519.pub";
    };
  };
}
