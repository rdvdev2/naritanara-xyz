{ moduleWithSystem, ... }:

{
  imports = [ ./tests ];
  
  flake.nixosModules.naritanara-xyz = moduleWithSystem (
    { config }:
    {
        imports = [ ./static-web-server.nix ];
        
        services.naritanara-xyz.package = config.packages.naritanara-xyz;
    }
  );
}