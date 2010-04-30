# Copyright (c) 2010, Mickaël Delahaye <mickael.delahaye@gmail.com>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED “AS IS” AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

OCAMLC=ocamlc
OCAMLOPT=ocamlopt
OCAMLDEP=ocamldep

OCAMLBFLAGS=
OCAMLOFLAGS=
OCAMLDEPFLAGS=

INSTALL_DIR=$(shell ocamlc -where)/oclock
STUBLIBS_DIR=$(shell ocamlc -where)/stublibs

################################################################################

OCAMLDEP:=$(OCAMLDEP) $(OCAMLDEPFLAGS)
OCAMLC:=$(OCAMLC) $(OCAMLBFLAGS)
OCAMLOPT:=$(OCAMLOPT) $(OCAMLOFLAGS)

all: byte native

byte: oclock.cma dlloclock.so
native: oclock.cmxa liboclock.a oclock.a

# Generic library compilation

%.cma: %.cmo dll%.so
	$(OCAMLC) -dllib -l$(@:.cma=) $< -a -o $@
%.cmxa: %.cmx lib%.a
	$(OCAMLOPT) -cclib -lrt -cclib -l$(@:.cmxa=) $< -a -o $@

lib%.a: %_stubs.o
	ar crs $@ $<
dll%.so: %_stubs.o
	$(LD) -shared -o $@ $< -lrt

# Generic Ocaml compilation

%.cmo:%.ml
	$(OCAMLC) -c $<
%.cmi:%.mli
	$(OCAMLC) -c $<
%.cmx:%.ml
	$(OCAMLOPT) -c $<

# Dependencies
.depend:
	$(OCAMLDEP) *.ml *.mli > .depend

-include .depend

# Cleaning
clean:
	$(RM) *.cmo *.cmi *.cmx
	
distclean: clean
	$(RM) *.cma *.cmxa *.a *.so

# (Un)Install
install:
	install -d $(INSTALL_DIR)
	install -t $(INSTALL_DIR) oclock.cma oclock.cmxa liboclock.a oclock.cmi oclock.a
	install -t $(STUBLIBS_DIR) dlloclock.so

uninstall:
	$(RM) $(INSTALL_DIR)/oclock.cma $(INSTALL_DIR)/oclock.cmxa $(INSTALL_DIR)/liboclock.a
	rmdir $(INSTALL_DIR)
	$(RM) $(STUBLIBS_DIR)/dlloclock.so

.PHONY: install clean distclean all
