{
  lib,
  pkgs,
}:
let pname = "comictagger";
  version = "1.6.0-alpha.8"; # renovate: datasource=github-tags depName=comictagger/comictagger versioning=semver nix=fetchurl
  name = "${pname}-${version}";

  src = pkgs.fetchurl {
    url = "https://github.com/comictagger/comictagger/releases/download/${version}/ComicTagger-x86_64.AppImage";
    hash = "sha256-FvD5VLWB2SJi4K4qgMrD0dp+hq5RKmLrfVbYpoPF/h4="; # renovate: datasource=github-tags depName=comictagger/comictagger
  };

  appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };

in
pkgs.appimageTools.wrapType2 rec {
  inherit name src;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    install -m 444 -D ${appimageContents}/AppRun.desktop $out/share/applications/${pname}.desktop

    install -m 444 -D ${appimageContents}/app.png $out/share/icons/hicolor/512x512/apps/${pname}.png

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=/home/runner/work/comictagger/comictagger/comictagger %F' 'Exec=${pname} %F'
  '';

  meta = with lib; {
    description = "App for writing  metadata to digital comics";
    homepage = "https://github.com/comictagger/comictagger";
    license = licenses.gpl3;
    platforms = [ "x86_64-linux" ];
  };
}