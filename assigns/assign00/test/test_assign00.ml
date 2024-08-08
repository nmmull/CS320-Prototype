open OUnit2

let tests = "Testing Assign00" >:::
  [ Test01.test_examples
  ; Test02.test_examples
  ; Grade01.basic_test
  ; Grade02.basic_test
  ]

let _ = run_test_tt_main tests
