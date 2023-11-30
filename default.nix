# This file lets you run `nix-build` and is called upon by docker.nix and shell.nix

let
  nixpkgs = import ./nixpkgs.nix {};
in
{ ... }:
  nixpkgs.pkgs.haskellPackages.callCabal2nix "serve" ./. {}
