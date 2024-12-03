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
      {
        devShells.default = pkgs.mkShell {
          buildInputs = build_deps;
        };
      }
    );
}
