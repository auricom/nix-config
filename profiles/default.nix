# Configuration that spans accross system and home, or are almagations of modules
{ ... }:
{
  imports = [
    ./bluetooth
    ./desktop-core
    ./devices
    ./kubeops
    ./gtk
    ./laptop
    ./ssd
    ./wireguard-client
    ./x
  ];
}
