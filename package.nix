{
  lib,
  patchelf,
  makeWrapper,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation {
  name = "zapret.fakeFiles";
  version = "git-06042025-e285b24";

  src = fetchFromGitHub {
    owner = "bol-van";
    repo = "zapret";
    rev = "e285b24";
    hash = "sha256-Sg18NhXGHB+XnSRFNHSQo8cGBuT1FVq/SXxYhnOuews=";
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
    maintainers = with lib.maintainers; [ s0me1newithhand7s ]; # aka hand7s
  };
}
