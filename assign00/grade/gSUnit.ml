open OUnit2

let uncurry f (x, y) = f x y

let rec drop n l =
  match n, l with
  | n, _ when n <= 0 -> l
  | _, [] -> l
  | n, _ :: xs -> drop (n - 1) xs

let take_sum f n l =
  let rec go n l out =
    match n, l with
    | n, _ when n <= 0 -> out
    | _, [] -> out
    | n, x :: xs -> go (n - 1) xs (out + f x)
  in go n l 0

let rec num_cases otest =
  let open OUnitTest in
  let sum = List.fold_left (+) 0 in
  match otest with
  | TestCase _ -> 1
  | TestList tests -> sum (List.map num_cases tests)
  | TestLabel (_, test) -> num_cases test

module Test_info = struct
  type t =
    { name : string
    ; max_score : int
    ; num_cases : int
    }

  let of_test otest max_score =
    let open OUnitTest in
    let name =
      match otest with
      | TestLabel (name, _) -> name
      | _ -> ""
    in
    { name
    ; max_score
    ; num_cases = num_cases otest
    }
end

let test_infos =
  List.rev_map (uncurry Test_info.of_test)

module Test_result = struct
  type t =
    { info : Test_info.t
    ; num_passed : int
    }

  let score r =
    let max_score = float_of_int r.info.max_score in
    let num_passed = float_of_int r.num_passed in
    let num_cases = float_of_int r.info.num_cases in
    if r.info.num_cases = 0
    then 0.
    else max_score *. num_passed /. num_cases

  let to_json r =
    let body =
      String.concat ",\n"
        [ "\"name\": " ^ "\"" ^ r.info.name ^ "\""
        ; "\"max_score\": " ^ string_of_int r.info.max_score
        ; "\"score\": " ^ Printf.sprintf "%.2f" (score r)
        ; "\"visibility\": \"hidden\""
        ]
    in String.concat "\n" ["{";body;"}"]
end

let int_of_status status =
  let open OUnitTest in
  match status with
  | RSuccess -> 1
  | _ -> 0

type results = Test_result.t list

type fold_info =
  { out : results
  ; statuses : OUnitTest.result list
  }

let to_results statuses test_infos =
  let fold_info =
    { out = []
    ; statuses
    }
  in
  let op fold_info (test_info : Test_info.t) =
    let n = test_info.num_cases in
    let s = fold_info.statuses in
    let o = fold_info.out in
    { out =
      { info = test_info
      ; num_passed = take_sum int_of_status n s
      } :: o
    ; statuses = drop n s
    }
  in (List.fold_left op fold_info test_infos).out

let to_json results =
  String.concat "\n"
    [ "{"
    ;  "\"output\": \"Submission accepted.\""
    ; "\"tests\": ["
    ; String.concat ",\n" (List.map Test_result.to_json results)
    ; "]"
    ; "}"
    ]

let error_json =
  String.concat "\n"
    [ "{"
    ; "\"score\": 0"
    ; "\"output\": \"Error grading submission. Please contact course staff.\""
    ; "}"
    ]

let run_tests_gradescope tests_and_max_scores =
  try
    let (tests, _) = List.split tests_and_max_scores in
    let test_infos = test_infos tests_and_max_scores in
    let ounit_out =
      OUnitCore.run_test_tt
        (OUnitPropList.create ())
        OUnitLogger.null_logger
        OUnitRunner.sequential_runner
        OUnitChooser.simple
        ("Gradescope Suite" >::: tests)
    in
    let statuses = List.map (fun (_,status,_) -> status) ounit_out in
    print_string (to_json (to_results statuses test_infos))
  with _ -> print_string error_json
