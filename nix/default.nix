inputs@{ flake-parts, ... }:

let flake =
{ self, ...}:
{
  imports = [
    inputs.pkgs-by-name-for-flake-parts.flakeModule
    inputs.devshell.flakeModule
    
    ./nixos
    ./devshell.nix
  ];
  
  systems = [ "x86_64-linux" ];
    
  perSystem = { self', ... }: {
    pkgsDirectory = ./pkgs;
    packages.default = self'.packages.naritanara-xyz;
  };
  
  flake = {
    nixosModules.default = self.nixosModules.naritanara-xyz;
  };
};
in

flake-parts.lib.mkFlake { inherit inputs; } flake