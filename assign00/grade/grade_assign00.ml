open GSUnit

let tests =
  [ Test01.basic_test, 5
  ; Test02.basic_test, 5
  ]

let _ = run_tests_gradescope tests
