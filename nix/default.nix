inputs@{ flake-parts, ... }:

let flake =
{ self, ...}:
{
  imports = [
    inputs.pkgs-by-name-for-flake-parts.flakeModule
    inputs.devshell.flakeModule
    inputs.git-hooks-nix.flakeModule
    inputs.actions-nix.flakeModules.default
    
    ./ci
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