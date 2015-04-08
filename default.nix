{ mkDerivation, base, clckwrks, clckwrks-plugin-page
, clckwrks-theme-bootstrap, containers, happstack-server, hsp
, hsx2hs, mtl, stdenv, text, web-plugins
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
  buildTools = [ hsx2hs ];
  homepage = "http://www.clckwrks.com/";
  description = "an example clckwrks site";
  license = stdenv.lib.licenses.bsd3;
}
