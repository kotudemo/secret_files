This flake brings [zapret](https://github.com/bol-van/zapret) binaries and to NixOS \
Example configuration:
```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    secret_files.url = "github:kotudemo/secret_files";

  };

  outputs = {
    self,
    nixpkgs,
    secret_files,
    ...
  } @ inputs:
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem rec {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
```
```nix
# configuration.nix

  environment = {
	  systemPackages = with pkgs; [
      inputs.secret_files.packages.${pkgs.system}.files
    ];
  };

  services = {
    zapret = {
      enable = true;
      udpSupport = true;
      udpPorts = [
        "50000:50099"
        "443"
      ];
      params = [
        "--filter-udp=50000-50099"
        "--dpi-desync=fake"
        "--dpi-desync-any-protocol"
        "--new"
        "--filter-udp=443"
        "--dpi-desync-fake-quic=${inputs.secret_files.packages.${pkgs.system}.files}/quic_initial_www_google_com.bin"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=2"
        "--new"
        "--filter-tcp=80,443"
        "--dpi-desync=fake,multidisorder"
        "--dpi-desync-ttl=3"
      ];
    };
  };
```

