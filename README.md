# CAS CS 320: Concepts of Programming Languages

This repository contains a rough outline of a prototype structure for
assignments in CS320.  The main differences compared to what has been done in
the past:

* Assignments are `dune` projects

* There is a course standard library, which disallows the use of the standard
  library (so that students don't use things like `ref`s)

* Grading is integrated with `OUnit2`, so that we can give students unit tests
  instead of exposing autograders

## Student Setup

1. [Install `opam`](https://opam.ocaml.org/doc/Install.html) (for Windows
   users, we recommend setting up a [WSL
   environment](https://learn.microsoft.com/en-us/windows/wsl/setup/environment))

2. Mirror the public course repository (as we did [last
   semester](https://github.com/BU-CS320/cs320-spring-2024/blob/main/README.md))

3. Run the following commands from within your local repository

   ```
   opam switch create ./ 4.13.1
   opam install dune utop ounit2
   opam install stdlib320/.
   ```
   The first command creates a local switch within the repository using the
   compiler for OCaml 4.13.1.  The next command installs `dune`, `utop`, and
   `ounit2`.  The last command installs the course standard library

6. (Optional) If you are using VSCode, install the OCaml language server protocol:
   ```
   opam install ocaml-lsp-server
   ```
   Then install the [OCaml
   Platform](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform)
   from the Visual Studio Marketplace

## Student Workflow

1. Sync with the course repository when changes to an assignment are made

   ```
   git fetch upstream
   git merge upstream/main main
   ```

2. Set the local switch to be the currently active switch

   ```
   eval $(opam env)
   ```

3. Fill in your solutions to the assignment/mini-project

4. Build to the project frequently to make sure your code compiles

   ```
   dune build
   ```

5. Test your code against a small test suite as you get close to a final solution

   ```
   dune test
   ```

6. (Optional) Add OUnit tests to the `test` directory

7. Submit the assignment/mini-project via Gradescope (by connecting your github
   account).

## Staff Workflow

1. For each assignment, create a library project via dune for the solutions in
   the development repository

   ```
   dune init project --kind=library assignXX
   ```

2. Add the following to the library stanza in `lib/dune`:

   ```
   (wrapped false)
   (flags (:standard -nostdlib -nopervasives -open Stdlib320))
   ```

3. Fill in the solutions and create unit tests.  It's best to put the unit
   tests in a separate library with its own directory and dune file (e.g.,
   `test/test_suite`) so that they are accessible to the grading script.  The
   tests should be separated into public tests which are given to the students,
   and private tests which are used for grading.

4. Add a `grade` directory to the project with the grading scripts
   (`gSUnit.ml`) and a dune file with an executable whose public name is
   `grade`, e.g.,

   ```
   (executable
    (name grade_assignXX)
    (public_name grade)
    (libraries ounit2 assignXX test_suite))
   ```

   The file `grade_assignXX.ml` should have one call to a function
   `run_tests_gradescope` which takes a list of pairs of OUnit tests and point
   values, e.g.,

   ```
   let tests =
     [ Test01.test_examples, 2
     ; Test02.test_examples, 2
     ; Grade01.basic_test, 8
     ; Grade02.basic_test, 8
     ]
   ```

   You can check the output of the autograder given to gradescope using dune.

   ```
   dune exec grade
   ```

4. To create an autograder, you just have to zip up the assignment (with the
   same file structure as in the public repository) with the standard library
   and the scripts `run.sh`, `setup.sh` and the appropriate instantiation of
   `run_autograder`.  This is done by the (not terribly robust) script
   `build.sh`.  (Note: The point is that the solution built in the developer
   repository is the exact environment in which a student submission will be
   graded. These scripts copy the student `.ml` files into the project and run
   `dune exec grade` from there.)

