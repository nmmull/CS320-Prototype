let sqrt (n : int) : int =
  let rec go i =
    if n <= i * i
    then i
    else go (i + 1)
  in
  if n < 0
  then failwith "negative input"
  else go 0
