---
title: Home
layout: default
---

Precise POSIX clock for OCaml

This library uses the clock_gettime(2) family of functions, to get precisions
from below the milliseconds upto the nanoseconds depending on the platform
(system and CPU). It lets you measure time from the real-time clock, monotonic
clocks, or CPU-time clocks of the current process, of a remote process, or of
a thread.

* [API (ocamldoc)](api/Oclock.html)
* [Repo](http://github.com/polazarus/oclock)

Requirements
============

Just the usual suspects: GNU Make, GCC, OCaml, and optionally Findlib (i.e.,
ocamlfind).

Installation
============

    $ make
Build the library

    # make install
Install the library in the standard ocaml directory

Usage
=====

Manually:
    ocamlc -I +oclock oclock.cma ...
    ocamlopt -I +oclock oclock.cmxa ...

Or with ocamlfind:
    ocamlfind ocamlc -package oclock ...
    ocamlfind ocamlopt -package oclock ...

Documentation
=============

To build the API documentation in HTML, use:
    $ make doc
Then, open `doc/index.html` with your favorite browser.

Two examples are also provided in `examples`:

*   _getcputime_ gets the CPU-time consumed by a process given by its PID.
*   _realtime_ gets the real time since the Epoch, and evaluates the clock
    precision.


License
=======

Copyright (c) 2010, Mickaël Delahaye

Permission to use, copy, modify, and/or distribute this software for any purpose
with or without fee is hereby granted, provided that the above copyright notice
and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED “AS IS” AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF
THIS SOFTWARE.

