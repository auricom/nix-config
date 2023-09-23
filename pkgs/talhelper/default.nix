{ lib, buildGoModule, fetchFromGitHub, installShellFiles, stdenv }:
buildGoModule rec {
  pname = "talhelper";
  version = "1.12.0";

  src = fetchFromGitHub {
    owner = "budimanjojo";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-lJqWttHra5IrnE4JoI+sqVlTAXrqoVXC7Gb7Y2r4SIA=";
  };

  vendorSha256 = "sha256-TsP3zSw0TAbvo2BMVjgsCu0nbT7P69LSEa3KNx7gPYw=";

  ldflags = [ "-s -w -X github.com/budimanjojo/talhelper/cmd.version=v${version}" ];

  doCheck = false; # no tests

  nativeBuildInputs = [ installShellFiles ];

  doInstallCheck = true;
  installCheckPhase = ''
    $out/bin/talhelper --version | versionhelper.$shell
    done
  '';

  meta = with lib; {
    description = "A tool to help creating Talos kubernetes cluster";
    longDescription = ''
      Talhelper is a helper tool to help creating Talos Linux cluster 
      in your GitOps repository.
    '';
    homepage = "https://github.com/budimanjojo/talhelper";
    license = licenses.bsd3;
  };
}