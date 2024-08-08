open OUnit2

module Reference = struct
  let sqrt n =
    let rec loop i =
      if i * i < n
      then loop (i + 1)
      else i
    in loop 0
end

let basic_test =
  let test i =
    let d = "Testing sqrt " ^ string_of_int i in
    let e = Reference.sqrt i in
    let a = Assign00_01.sqrt i in
    let t _ = assert_equal e a in
    d >:: t
  in
  "Testing Problem 1" >::: List.init 100 test
