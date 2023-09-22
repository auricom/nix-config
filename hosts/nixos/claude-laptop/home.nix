{ pkgs, ... }:
{
  my.home = {

    # Machine specific packages
    packages.additionalPackages = with pkgs; [
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
  };
}