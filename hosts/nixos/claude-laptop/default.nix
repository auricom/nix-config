# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, ... }:
{
  imports = [
    ./boot.nix
    ./disko.nix
    ./hardware.nix
    ./home.nix
    ./networking.nix
    ./profiles.nix
    ./programs.nix
    ./services.nix
    ./sound.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
  ];

  age.rekey = {
    # Obtain this using `ssh-keyscan` or by looking it up in your ~/.ssh/known_hosts
    hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINRZVQ23ywGUy4PGssAVTlUt8a49FIpFDrW8VG2HWpqV";
    # The path to the master identity used for decryption. See the option's description for more information.
    masterIdentities = [ /home/claude/.ssh/id_ed25519 ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
