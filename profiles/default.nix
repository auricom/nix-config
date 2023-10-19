# Configuration that spans accross system and home, or are almagations of modules
{...}: {
  imports = [
    ./bluetooth
    ./desktop-core
    ./kubeops
    ./gtk
    ./laptop
    ./wireguard-client
    ./x
  ];
}
