{
  lib,
  patchelf,
  makeWrapper,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation {
  name = "zapret.secret_files";
  version = "git-06042025-e285b24";

  src = fetchFromGitHub {
    owner = "bol-van";
    repo = "zapret";
    rev = "c14554c1f3b71b41d017a3d8c6306a059f658e18";
    hash = "sha256-bBiUauYH5d68VNvK0E/6l3G1myb8oWgm5IoHiWCcbpg=";
  };

  nativeBuildInputs = [
    makeWrapper
    patchelf
  ];

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir $out
    cp -r -a files/fake/* $out/

    runHook postInstall
  '';

  meta = {
    description = "binaries from bol-van/zapret repository";
    homepage = "https://www.github.com/bol-van/zapret";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [kotudemo];
  };
}
