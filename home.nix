{ config, pkgs, ... }:

{
  # TODO please change the username & home direcotry to your own
  home.username = "claude";
  home.homeDirectory = "/home/claude";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

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

  programs.fish.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
