{ stdenv, fetchFromGitHub, xbacklight, xrandr, xset }:

stdenv.mkDerivation rec {
  name = "assorted-scripts-0.0.2";

  src = fetchFromGitHub {
    owner = "samuelrivas";
    repo = "assorted-scripts";
    rev = "517b9521aaac98a1b9527888c0f919357c42e0dc";
    sha256 = "1l3jyqgddd0lm0macxap8sz83hjzqwi1frynlikd3gxlafrrvidy";
  };

  inherit xbacklight xrandr xset;

  buildInputs = [ ];

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
