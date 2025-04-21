{ lib, config, pkgs, ... }:

let
  cfg = config.services.naritanara-xyz;
in

{
  options.services.naritanara-xyz = {
    enable = lib.mkEnableOption "the naritanara.xyz web server";
    
    package = lib.mkPackageOption pkgs "naritanara-xyz" {
      default = null;
      extraDescription = lib.literalMD "From the naritanara-xyz flake.";
    };
    
    port = lib.mkOption {
      description = "The port on which the web server will listen.";
      type = lib.types.port;
      default = 80;
    };
  };
  
  config = lib.mkIf cfg.enable {
    services.static-web-server = {
      enable = true;
      root = "${cfg.package}";
      listen = "[::]:${toString cfg.port}";
    };
  };
}