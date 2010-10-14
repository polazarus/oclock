OCAMLC ?= ocamlc
OCAMLOPT ?= ocamlopt

OCLOCKPATH = $(shell which ocamlfind>/dev/null && ocamlfind query oclock || echo +oclock)
OCAMLC += -I $(OCLOCKPATH)
OCAMLOPT += -I $(OCLOCKPATH)

EXAMPLES=realtime getcputime

all: $(EXAMPLES:%=%.byte) $(EXAMPLES:%=%.opt)

# Generic Ocaml compilation
%.cmo:%.ml
	$(OCAMLC) -c $<
%.cmi:%.mli
	$(OCAMLC) -c $<
%.cmx:%.ml
	$(OCAMLOPT) -c $<

# Generic linking
%.byte:%.cmo
	$(OCAMLC) -o $@ oclock.cma $<
%.opt:%.cmx
	$(OCAMLOPT) -o $@ oclock.cmxa $<

# Cleaning
clean:
	$(RM) *.cmo *.cmi *.o
distclean:
	$(RM) *.byte *.opt

# Phony targets
.PHONY: clean distclean all
