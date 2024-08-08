open OUnit2

let tests = "Testing Assign00" >:::
  [ Test01.basic_test
  ; Test02.basic_test
  ]

let _ = run_test_tt_main tests
