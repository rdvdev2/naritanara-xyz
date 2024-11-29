{
  description = "Flake describing the website naritanara.xyz";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        build_deps = with pkgs; [ zola ];
      in
      rec {
        devShells.default = pkgs.mkShell {
          buildInputs = build_deps;
        };

        packages.default = packages.website;

        packages.website = pkgs.stdenv.mkDerivation {
          name = "naritanara-xyz";
          src = ./.;
          dontUnpack = true;
          sourceRoot = ".";

          buildInputs = build_deps;

          buildPhase = ''
            cd $src
            zola build -o $out
          '';
        };

        packages.website-server = pkgs.writeShellScriptBin
          "naritanara-xyz-server" ''
            ${pkgs.static-web-server}/bin/static-web-server --root ${packages.website} -p 80 $@
          '';

        packages.docker-image = pkgs.dockerTools.buildLayeredImage {
          name = "naritanara-xyz";
          tag = "latest";
          config = {
            Cmd = ["${packages.website-server}/bin/naritanara-xyz-server"];
            ExposedPorts = {
              "80/tcp" = {};
            };
          };
        };
      }
    );
}
