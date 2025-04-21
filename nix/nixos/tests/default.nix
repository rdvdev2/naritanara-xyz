{ self, ... }:

let
    basenameWithoutExtension = x: builtins.head (builtins.split "\\." (baseNameOf x));
    asNixOSTestWithModules = (pkgs: modules: testPath:
      rec {
        name = basenameWithoutExtension testPath;
        value = pkgs.testers.runNixOSTest (
            import testPath // {
                inherit name;
                defaults.imports = modules;
            });
      }
    );
    testPaths = let
      dirPaths = builtins.attrNames (builtins.readDir ./.);
      isNotSelf = filename: filename != "default.nix";
      asRelativePath = filename: ./${filename};
    in
      builtins.map asRelativePath (builtins.filter isNotSelf dirPaths);
in

{
  perSystem = { pkgs, ... }: {
    checks = builtins.listToAttrs (builtins.map (asNixOSTestWithModules pkgs [ self.nixosModules.default ]) testPaths);
  };
}