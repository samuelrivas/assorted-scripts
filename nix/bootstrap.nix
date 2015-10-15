{ system ? builtins.currentSystem }:
let
  pkgs = import <nixpkgs> { inherit system; };

  callPackage =
    pkgs.lib.callPackageWith (  pkgs
                             // pkgs.xlibs
                             // self);

  self = rec {
    assortedScripts = callPackage ./assorted-scripts.nix { };
  };
in
self
