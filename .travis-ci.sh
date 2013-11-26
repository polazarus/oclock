#!/bin/sh
OPAM_DEPENDS="ocamlfind ounit"
	 
case "$OCAML_VERSION" in
3.12.1) ppa=avsm/ocaml312+opam11 ;;
4.00.1) ppa=avsm/ocaml40+opam11 ;;
4.01.0) ppa=avsm/ocaml41+opam11 ;;
*) echo "Unknown ocaml version: $OCAML_VERSION"; exit 1 ;;
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


make
make test
make install
make install-test
