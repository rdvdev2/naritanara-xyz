inputs@{ flake-parts, ... }:

  flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      inputs.pkgs-by-name-for-flake-parts.flakeModule
      inputs.devshell.flakeModule
      
      ./devshell.nix
    ];
    
    systems = [ "x86_64-linux" ];
    
    perSystem = { self', ... }: {
      pkgsDirectory = ./pkgs;
      packages.default = self'.packages.naritanara-xyz;
    };
  }