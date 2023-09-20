# Hardware-related modules
{ ... }:

{
  imports = [
    ./bluetooth
    ./firmware
    ./networking
    ./sound
    ./upower
  ];
}