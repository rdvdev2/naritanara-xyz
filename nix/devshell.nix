{ lib, ... }:

let
  packageToDevshell = package: lib.mkMerge [
    {
      devshell = {
        name = package.name;
        packagesFrom = [ package ];
      };
      
      serviceGroups.website = {
        description = "hot-reload dev server";
        services.zola.command = "zola serve";
      };
      
      commands = [
        {
          name = "check";
          command = "zola check";
          help = "Try to build the site without generating files.";
          category = "zola";
        }
        {
          name = "render-workflows";
          command = "nix run '.#render-workflows'";
          help = "Render GitHub workflows with actions.nix.";
          category = "ci";
        }
      ];
    }
  ];
in

{
  perSystem = { self', ... }: {
    devshells = builtins.mapAttrs (_: packageToDevshell) self'.packages;
  };
}