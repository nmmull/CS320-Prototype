open OUnit2

module Reference = struct
  let is_prime (n : int) : bool =
    let rec loop (i : int) : bool =
      if n < i * i then true else
      if n mod i = 0 then false
      else loop (i + 1)
    in
    if n < 2 then false
    else loop 2
end

let basic_test =
  let test i =
    let d = "Testing prime " ^ string_of_int i in
    let e = Reference.is_prime i in
    let a = Assign00_02.is_prime i in
    let t _ = assert_equal e a in
    d >:: t
  in
  "Testing Problem 2" >::: List.init 100 test
