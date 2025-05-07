{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ] (system: function nixpkgs.legacyPackages.${system});
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);
    packages = forAllSystems (pkgs: {
      files = pkgs.callPackage ./package.nix;
    });
  };
}
