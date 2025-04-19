{ lib
, stdenv
, zola
}:

stdenv.mkDerivation {
  name = "naritanara-xyz";
  
  src = ../..;
  
  nativeBuildInputs = [
    zola
  ];
  
  buildPhase = ''
    zola build --output-dir $out
  '';
  
  meta = with lib; {
    description = "Static files for naritanara.xyz";
    homepage = "https://naritanara.xyz";
    license = licenses.gpl3Plus;
    platforms = platforms.all;
  };
}