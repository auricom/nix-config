{
  lib,
  fetchurl,
  appimageTools,
}: let
  pname = "openlens";
  version = "6.5.2-366"; # renovate: datasource=github-tags depName=MuhammedKalkan/OpenLens versioning=semver nix=fetchurl
  version_mod = builtins.replaceStrings ["v"] [""] version;

  src = fetchurl {
    url = "https://github.com/MuhammedKalkan/OpenLens/releases/download/v${version}/OpenLens-${version}.x86_64.AppImage";
    hash = "sha256-ZAltAS/U/xh4kCT7vQ+NHAzWV7z0uE5GMQICHKSdj8k="; # renovate: datasource=github-tags depName=MuhammedKalkan/OpenLens
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
  appimageTools.wrapType2 {
    inherit pname version src;
    unshareIpc = false;

    extraInstallCommands = ''
      mv $out/bin/${pname}-${version} $out/bin/${pname}

      install -m 444 -D ${appimageContents}/open-lens.desktop $out/share/applications/${pname}.desktop
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/512x512/apps/open-lens.png \
        $out/share/icons/hicolor/512x512/apps/${pname}.png

      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Icon=open-lens' 'Icon=${pname}' \
        --replace 'Exec=AppRun' 'Exec=${pname} -disable-gpu'
    '';

    meta = with lib; {
      description = "The Kubernetes IDE";
      homepage = "https://github.com/MuhammedKalkan/OpenLens";
      license = licenses.mit;
      maintainers = with maintainers; [benwbooth sebtm];
      platforms = ["x86_64-linux"];
    };
  }
