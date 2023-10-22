{pkgs}:
pkgs.lib.makeScope pkgs.newScope (pkgs: {
  comictagger = pkgs.callPackage ./comictagger {};

  ff2mpv-go = pkgs.callPackage ./ff2mpv-go {};

  kopia-ui = pkgs.callPackage ./kopia-ui {};
})
