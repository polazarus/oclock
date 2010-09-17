OCAMLC ?= ocamlc
OCAMLOPT ?= ocamlopt

OCAMLC += -I +oclock
OCAMLOPT += -I +oclock

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
