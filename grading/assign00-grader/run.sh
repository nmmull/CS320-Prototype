#!/usr/bin/env bash

ASSIGNDIR="$1"
SOURCE="/autograder/source/$ASSIGNDIR"
SUBMISSION="/autograder/submission/$ASSIGNDIR"

rm $SOURCE/lib/*.ml
cp $SUBMISSION/lib/*.ml $SOURCE/lib
cd $SOURCE
eval $(opam env)
dune clean
dune exec grade > /autograder/results/results.json

