#!/bin/sh

eval `opam config env`
make
make test
make install
make install-test
