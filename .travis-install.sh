#!/bin/sh

OPAM_DEPENDS="ocamlfind ounit"

case "$OCAML_VERSION" in
''|4|4.1|4.01|4.01.0) ppa=avsm/ocaml41 ;;
4.0|4.00|4.0.1|4.00.1) ppa=avsm/ocaml40 ;;
3|3.12|3.12.1) ppa=avsm/ocaml312 ;;
*) echo "Unknown ocaml version: $OCAML_VERSION"; exit 1 ;;
esac

case "$OPAM_VERSION" in
''|1|1.1|1.1.0) ppa=$ppa+opam11 ;;
1.0|1.0.0) ppa=$ppa+opam10 ;;
*) echo "Unknown opam version: $OPAM_VERSION"; exit 1;;
esac

echo "yes" | sudo add-apt-repository ppa:$ppa
sudo apt-get update -qq
sudo apt-get install -qq ocaml-nox ocaml-native-compilers opam

export OPAMYES=1
opam init
opam install ${OPAM_DEPENDS}
eval `opam config env`

echo -n 'Ocaml version '
ocaml -version
echo -n 'OPAM version '
opam --version
