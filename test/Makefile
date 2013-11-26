# Copyright (c) 2011-2013, Mickaël Delahaye, http://micdel.fr
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

OCAMLFIND=ocamlfind

check test: test.opt test.byte
	./test.opt
	./test.byte
	
installcheck installtest: installtest.opt installtest.byte
	./installtest.opt
	./installtest.byte

test.opt: test.ml
	$(OCAMLFIND) ocamlopt -package oUnit -linkpkg -I .. -ccopt -L.. oclock.cmxa test.ml -o $@
test.byte: test.ml
	$(OCAMLFIND) ocamlc -package oUnit -linkpkg -I .. -dllpath .. -ccopt -L.. oclock.cma test.ml -o $@


installtest.opt: test.ml
	$(OCAMLFIND) ocamlopt -package oUnit -package oclock -linkpkg test.ml -o $@
installtest.byte: test.ml
	$(OCAMLFIND) ocamlc -package oUnit -package oclock -linkpkg test.ml -o $@

clean:
	$(RM) *.cmo *.cmi *.cmx
distclean: clean
	$(RM) *.byte *.opt

.PHONY: test installtest check installcheck clean distclean
