# Edit this for your own project dependencies
OPAM_DEPENDS="ocamlfind ounit"
	 
case "$OCAML_VERSION" in
3.12.1) ppa=avsm/ocaml312+opam11 ;;
4.00.1) ppa=avsm/ocaml40+opam11 ;;
4.01.0) ppa=avsm/ocaml41+opam11 ;;
*) echo Unknown $OCAML_VERSION; exit 1 ;;
esac

echo "yes" | sudo add-apt-repository ppa:$ppa
sudo apt-get update -qq

if [ -n "$X86_32" ]; then
sudo apt-get install ocaml-nox:i386 ocaml-native-compilers:i386 camlp4-extra:i386 opam:i386 gcc:i386 binutils:i386
else
sudo apt-get install -qq ocaml-nox ocaml-native-compilers camlp4-extra opam
fi
	 

export OPAMYES=1

echo Ocaml version
ocaml -version
echo OPAM version
opam --version

opam init 
opam install ${OPAM_DEPENDS}
eval `opam config env`
make
make test
make install
make install-test
