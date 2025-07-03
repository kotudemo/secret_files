{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    forAllSystems = f:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ] (system: f (import nixpkgs {inherit system;}));
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);
    packages = forAllSystems (pkgs: {
      files = pkgs.callPackage ./package.nix {};
    });
  };
}
