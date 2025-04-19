{
  description = "Flake describing the website naritanara.xyz";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
    devshell.url = "github:numtide/devshell";
  };

  outputs = inputs: import ./nix inputs;
}
