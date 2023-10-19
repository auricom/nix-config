{pkgs}:
pkgs.lib.makeScope pkgs.newScope (pkgs: {
  ff2mpv-go = pkgs.callPackage ./ff2mpv-go {};
})
