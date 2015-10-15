{ stdenv,
  gawk,
  makeWrapper,
  which,
  xbacklight,
  xrandr,
  xset
}:

stdenv.mkDerivation rec {
  name = "assorted-scripts-dev";

  src = ./..;

  inherit gawk which xbacklight xrandr xset;

  buildInputs = [
    makeWrapper
  ];

  dontBuild = true;
  dontStrip = true;
  dontPatchELF = true;

  installPhase = ./install.sh;
  postFixup = ./post-fixup.sh;

  meta = {
    description = "A collection of barely useful scripts";
    homepage = https://github.com/samuelrivas/assorted-scripts;
    license = stdenv.lib.licenses.bsd3;
    maintainers = [ "Samuel Rivas <samuelrivas@gmail.com>" ];
  };
}
