{ config, pkgs, ... }:
{

  imports = [
    ./bluetooth
    # ./gtk
    ./packages
    ./power-alert
    # ./x
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "auricom";
    userEmail = "27022259+auricom@users.noreply.github.com";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    
    # cli
    curl
    chezmoi
    gh
    minio-client
    nmap
    sops
    tmux
    
    # archives
    zip
    xz
    unzip
    p7zip
    
    # shell bin replcaements
    bat
    bat-extras.batgrep
    fd
    fzf
    lf
    lsd
    ripgrep
    
    # debug
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    nmap
    stress
    s-tui
    
    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
    
    # dev/admin
    git
    go-task
    jq
    pre-commit
    yq-go
    
    # kubernetes
    fluxcd
    kubectl
    kubeconform
    kubernetes-helm
    helm-docs
    kustomize
    openlens
    popeye
    
    # python
    # unstable.python3Packages.comictagger
    # unstable.python3Packages.pip
    # unstable.python3Packages.setuptools
    # unstable.python3Packages.virtualenvwrapper
    
    # desktop
    _1password-gui
    bitwarden
    calibre
    deadbeef-with-plugins
    discord
    joplin-desktop
    kopia
    librewolf
    mediainfo-gui
    mpv
    picard
    pinta
    remmina
    vlc
    vscodium
    
    # servers
    resilio-sync
  ];

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  home.stateVersion = "23.05";
  
  home.username = "claude";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Start services automatically
  systemd.user.startServices = "sd-switch";
}