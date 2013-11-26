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
SUFFIX=":i386"
sudo apt-get install ocaml$SUFFIX ocaml-native-compilers$SUFFIX camlp4-extra$SUFFIX opam$SUFFIX
else
sudo apt-get install -qq ocaml$SUFFIX ocaml-native-compilers$SUFFIX camlp4-extra$SUFFIX opam$SUFFIX
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
