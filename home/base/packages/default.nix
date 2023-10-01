{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.packages;
in
{
  options.my.home.packages = with lib; {
    enable = my.mkDisableOption "user packages";

    additionalPackages = mkOption {
      type = with types; listOf package;
      default = [ ];
      example = literalExample ''
        with pkgs; [
          quasselClient
        ]
      '';
    };
  };

  config.home.packages = with pkgs; lib.mkIf cfg.enable ([
    fd
    file
    fzf
    mosh
    ripgrep
    pv

    # compilation
    gcc

    # debug
    iotop # io monitoring
    iftop # network monitoring
    nmap
    nmon
    stress
    s-tui

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    bpftrace # powerful tracing tool
    tcpdump  # network sniffer
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    hdparm # for disk performance, command
    dmidecode # a tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard
  ] ++ cfg.additionalPackages);

    config.home.sessionVariables = {
      # Cattpuccin Macchiato - https://github.com/catppuccin/fzf
      FZF_DEFAULT_OPTS = ''\
        --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
        --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
        --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
      '';
    };

  # auto mount usb drives
  config.services = {
    udiskie.enable = true;
  };
}
