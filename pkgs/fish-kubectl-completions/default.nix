{ lib, fish, stdenvNoCC }:
stdenvNoCC.mkDerivation rec {
  pname = "fish-kubectl-completions";
  version = "0.1.0";

  script = fish-kubectl-completions.fish;
  src = "./$script";

  nativeBuildInputs = [
    makeWrapper
  ];

  dontUnpack = true;

  dontBuild = true;

  installPhase = ''
    completionsdir="$out/share/fish/completions"
    mkdir -p $completionsdir
    cp $src $out/completions/$script
    chmod a+x $out/completions/$script
  '';

  meta = with lib; {
    description = "kubectl completions for fish shell";
    homepage = "https://github.com/evanlucas/fish-kubectl-completions";
    license = with licenses; [ mit ];
    mainProgram = "fish-kubectl-completions";
    maintainers = with maintainers; [ ambroisie ];
    platforms = platforms.linux;
  };
}