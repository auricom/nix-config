{ pkgs }:
pkgs.lib.makeScope pkgs.newScope (pkgs: {
  fish-kubectl-completions = pkgs.callPackage ./fish-kubectl-completionss { };

})