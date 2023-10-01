{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.ssh-client;
in
{
  options.my.home.ssh-client = with lib; {
    enable = mkEnableOption "ssh-client configuration";
  };

  config.programs.ssh = {
    enable = true;

    # all my ssh private key are generated by `ssh-keygen -t ed25519 -C "ryan@nickname"`
    # the config's format:
    #   Host —  given the pattern used to match against the host name given on the command line.
    #   HostName — specify nickname or abbreviation for host
    #   IdentityFile — the location of your SSH key authentication file for the account.
    # format in details:
    #   https://www.ssh.com/academy/ssh/config
    extraConfig = ''
      # a private key that is used during authentication will be added to ssh-agent if it is running
      AddKeysToAgent yes

      Host 192.168.*
        # allow to securely use local SSH agent to authenticate on the remote machine.
        # It has the same effect as adding cli option `ssh -A user@host`
        ForwardAgent yes
        IdentityFile ~/.ssh/id_ed25519
        # Specifies that ssh should only use the identity file explicitly configured above
        # required to prevent sending default identity files first.
        IdentitiesOnly yes

      Host github.com
          # github is controlled by claude
          IdentityFile ~/.ssh/claude
          # Specifies that ssh should only use the identity file explicitly configured above
          # required to prevent sending default identity files first.
          IdentitiesOnly yes

      Host opnsense
        HostName 192.168.8.1
        Port 22

      Host pikvm
        HostName 192.168.8.200
        Port 22

      Host truenas
        HostName 192.168.9.10
        Port 22

      Host truenas-remote
        HostName 10.10.0.20
        Port 22
        ForwardAgent yes
        IdentityFile ~/.ssh/id_ed25519

      Host coreelec
        HostName 192.168.9.60
        Port 22
    '';
  };
}
