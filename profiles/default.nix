# Configuration that spans accross system and home, or are almagations of modules
{...}: {
  imports = [
    ./bluetooth
    ./desktop-core
    ./homelab
    ./kubeops
    ./gtk
    ./laptop
    ./nvidia
    ./virt
    ./wireguard-client
    ./x
  ];
}
