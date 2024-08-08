open GSUnit

let tests =
  [ Test01.test_examples, 2
  ; Test02.test_examples, 2
  ; Grade01.basic_test, 8
  ; Grade02.basic_test, 8
  ]

let _ = run_tests_gradescope tests
