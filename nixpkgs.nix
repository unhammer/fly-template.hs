# pin nix packages to a revision (this file is used by all the other .nix files)

let
  nixpkgs-source = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/4e6868b1aa3766ab1de169922bb3826143941973.tar.gz";
  };
in
  import nixpkgs-source
