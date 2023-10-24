{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.hardware.nvidia;
in {
  options.my.hardware.nvidia = with lib; {
    enable = mkEnableOption "nvidia configuration";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"]; # will install nvidia-vaapi-driver by default
    hardware.nvidia = {
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Modesetting is needed for most Wayland compositors
      modesetting.enable = true;
      # Use the open source version of the kernel module
      # Only available on driver 515.43.04+
      open = false;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.enable = false;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;
    };
    virtualisation.docker.enableNvidia = true; # for nvidia-docker

    # Enable OpenGL
    hardware.opengl = {
      enable = true;
      # if hardware.opengl.driSupport is enabled, mesa is installed and provides Vulkan for supported hardware.
      driSupport = true;
      # needed by nvidia-docker
      driSupport32Bit = true;
      #NVIDIA doesn't support libvdpau, so this package will redirect VDPAU calls to LIBVA.
      extraPackages = [pkgs.libvdpau-va-gl];
    };

    environment.sessionVariables.VDPAU_DRIVER = "va_gl";
    environment.sessionVariables.LIBVA_DRIVER_NAME = "nvidia";
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
