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
    rev = "f3d48b7160f5e257edf0adb302878488d4955095";
    hash = "sha256-Bzi4JwPxrYnG39wwRais2Gq1m1tPV44DlmrY3JkxXYE=";
  }

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
    maintainers = with lib.maintainers; [ kotudemo ]; 
  };
}
