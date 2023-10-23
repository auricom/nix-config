# Configuration that spans accross system and home, or are almagations of modules
{...}: {
  imports = [
    ./bluetooth
    ./desktop-core
    ./homelab
    ./kubeops
    ./gtk
    ./laptop
    ./wireguard-client
    ./x
  ];
}
