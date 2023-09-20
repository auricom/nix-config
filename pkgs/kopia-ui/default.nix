{
  lib,
  pkgs,
}: let
  pname = "kopia-ui";
  version = "v0.15.0"; # renovate: datasource=github-tags depName=kopia/kopia versioning=semver nix=fetchurl
  version_mod = builtins.replaceStrings ["v"] [""] version;
  name = "${pname}-${version}";

  src = pkgs.fetchurl {
    url = "https://github.com/kopia/kopia/releases/download/${version}/KopiaUI-${version_mod}.AppImage";
    hash = "sha256-Q7NXxnDrOXTtALx8vPanrUugW2AnXJifvto5phehOFQ="; # renovate: datasource=github-tags depName=kopia/kopia
  };

  appimageContents = pkgs.appimageTools.extractType2 {inherit name src;};
in
  pkgs.appimageTools.wrapType2 rec {
    inherit name src;

    extraInstallCommands = ''
      mv $out/bin/${name} $out/bin/${pname}
      install -m 444 -D ${appimageContents}/kopia-ui.desktop $out/share/applications/${pname}.desktop

      install -m 444 -D ${appimageContents}/kopia-ui.png $out/share/icons/hicolor/512x512/apps/${pname}.png

      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${pname} %U'
    '';

    meta = with lib; {
      description = "Fast and secure open-source backup/restore tool";
      homepage = "https://github.com/kopia/kopia";
      license = licenses.gpl3;
      platforms = ["x86_64-linux"];
    };
  }
