Oclock: Precise POSIX clock for OCaml
=====================================

Mickaël Delahaye, http://micdel.fr

This module provides access to precise time information (in nanoseconds) on
POSIX-compatible system (Linux, FreeBSD, OpenBSD, etc.). It is made possible
through the [`clock_gettime (2)` family of functions][1].

[![Build Status](https://travis-ci.org/polazarus/oclock.png)](https://travis-ci.org/polazarus/oclock)

Requirements
------------

Just the usual suspects: GNU Make, GCC, OCaml, and optionally Findlib (i.e.,
ocamlfind).

Also, a true POSIX system, i.e., not MacOS. Indeed MacOS does not support
`clock_gettime`. There are alternatives but I do not have a Mac... if you are
interested in extending the library, let me know.

Installation
------------

    $ make

Build the library.

    # make install

Install the library in the standard ocaml directory.

Usage
-----

Manually:

    ocamlc -I +oclock oclock.cma ...
    ocamlopt -I +oclock oclock.cmxa ...

Or with ocamlfind:

    ocamlfind ocamlc -package oclock ...
    ocamlfind ocamlopt -package oclock ...

Documentation
-------------

To build the API documentation in HTML, use:

    $ make doc

Then, open `doc/index.html` with your favorite browser.

Available clocks differ under the various POSIX systems (e.g., see [Linux][1],
[OpenBSD][2], and [FreeBSD][3] man-pages). Most differences between systems are
levelled out by the Ocaml interface.

Two examples are also provided in the `examples` directory:

*   `getcputime` gets the CPU-time consumed by a process given its PID.
*   `realtime` gets the real time since the Epoch, and evaluates the clock
    precision inside Ocaml.

License
-------
Copyright (c) 2011-2013, Mickaël Delahaye, http://micdel.fr

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

[1]: http://man7.org/linux/man-pages/man2/clock_gettime.2.html
[2]: http://www.openbsd.org/cgi-bin/man.cgi?query=clock_gettime&sektion=2
[3]: http://www.freebsd.org/cgi/man.cgi?query=clock_gettime&sektion=2
