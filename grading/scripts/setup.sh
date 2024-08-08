#! /user/bind/env bash

apt update
apt install -y opam
opam update
opam init -y --disable-sandboxing
eval $(opam env)
opam install -y dune ounit2
opam install -y /autograder/source/stdlib320/.
