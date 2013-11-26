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

sudo add-apt-repository -y ppa:$ppa
sudo apt-get update -qq
sudo apt-get install -qq ocaml-nox ocaml-native-compilers opam

opam init -y
eval `opam config env`
