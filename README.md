# CAS CS 320: Concepts of Programming Languages

## Student Setup

1. Install `opam` (for Windows users, we recommend using WSL)

2. Clone course repository. (Follow existing set-up with mirroring)

3. Create local switch in the (mirrored) repository by going to the repo via
`opam switch create ./`

4. Install dune and utop via `opam install dune utop`

5. install the CS320 standard library to the switch via `opam install
stdlib320/.` ignoring all warnings

6. (Optional) Set up VSCode with dune.

## Student Workflow

1. Pull down the repo when a new assignment is available.

2. Fill in your solutions.

3. Run `dune build` to check if your code compiles.

4. Run `dune test` to check your code against a small test suite.

5. (Optional) Add your own tests.

6. Submit via Gradescope.

## Staff Workflow

1. For each assignment, create a library project via dune for the solutions:
`dune init project --kind=library assignXX` in the dev repo.

2. Add the following to the library stanza in `lib/dune`:

   ```
   (wrapped false)
   (flags (:standard -nostdlib -nopervasives -open Stdlib320))
   ```

2. Fill in the solutions, create unit tests.  The tests should be separated
into public and private files.  Public tests should be put in a `test_suite`
library in the `test` directory.  Private tests should be put in the `grade`
directory.

3. To create an autograder, zip the assign with the std library and template
auxiliary files. (TODO: make this a make command).

4. Create an dune project for the assignment itself in the public repo.  Delete
any solutions and the `grade` directory.
