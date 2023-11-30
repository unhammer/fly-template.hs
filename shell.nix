# Gets called when you do `nix-shell`, includes development tools

{ pkgs    ? import ./nixpkgs.nix {}
}:
let
  serve = pkgs.callPackage ./default.nix {};
in
serve.env.overrideAttrs (oldEnv: {
  nativeBuildInputs = oldEnv.nativeBuildInputs
                      ++ [
                        pkgs.haskell-language-server
                        pkgs.stylish-haskell
                      ];
  shellHook = ''
  '';
})
