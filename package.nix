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
    rev = "99b54069058c50d81964f17b198616885b624a50";
    hash = "sha256-7UB9r0ah/jDf5q8MabDS288lKpTCvnPbG6vK56bZTz4=";
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
    maintainers = with lib.maintainers; [ kotudemo ]; 
  };
}
