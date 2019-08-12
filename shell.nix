with (import <nixpkgs> {}).pkgs;
let pkg = haskellPackages.callPackage
            ({ mkDerivation, base, clckwrks, clckwrks-plugin-page
             , clckwrks-theme-bootstrap, containers, happstack-server, hsp
             , hsx2hs, markdown, mtl, stdenv, text, web-plugins, pandoc, cabal-install
             }:
             mkDerivation {
               pname = "example-dot-org";
               version = "0.1.0.0";
               src = ./.;
               isLibrary = false;
               isExecutable = true;
               buildDepends = [
                 base clckwrks clckwrks-plugin-page clckwrks-theme-bootstrap
                 containers happstack-server hsp mtl text web-plugins
               ];
               buildTools = [ hsx2hs pandoc  cabal-install ];
               homepage = "http://www.clckwrks.com/";
               description = "an example clckwrks site";
               license = stdenv.lib.licenses.bsd3;
             }) {};
in
  pkg.env
