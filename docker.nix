# You can build, load and run the docker image locally like this:
# $ docker load < $(nix-build ./docker.nix --option sandbox false)
# $ docker run --rm -p 8180:8180 --name myapp myapp:latest

{ pkgs    ? import ./nixpkgs.nix {}
}:
let
  serve = pkgs.callPackage ./default.nix {};
  static = pkgs.stdenv.mkDerivation {
    name = "static";
    src = ./static;
    installPhase = ''
     mkdir -p $out/www/
     cp -r * $out/www/
   '';
  };
in
pkgs.dockerTools.buildImage {
  name = "myapp";               # must match the one in deploy.yml
  tag = "latest";

  copyToRoot = pkgs.buildEnv {
    name = "image-root";
    paths = [
      pkgs.bashInteractive
      pkgs.cacert
      serve
      static
    ];
    # By commenting out pathsToLink, all of ./src gets put into /
    pathsToLink = [
      "/bin"
      "/www"
    ];
  };

  config = {
    Env = [ "LC_ALL=C.UTF-8" ];
    Cmd = [ "serve" ];
    ExposedPorts = {
      "8180/tcp" = {};
    };
    WorkingDir = "/www";
  };
}
