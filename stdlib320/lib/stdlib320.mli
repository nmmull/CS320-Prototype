val raise : exn -> 'a
val failwith : string -> 'a
val ignore : 'a -> unit

val ( |> ) : 'a -> ('a -> 'b) -> 'b
val ( @@ ) : ('a -> 'b) -> 'a -> 'b

val ( = ) : 'a -> 'a -> bool
val ( <> ) : 'a -> 'a -> bool
val ( < ) : 'a -> 'a -> bool
val ( > ) : 'a -> 'a -> bool
val ( <= ) : 'a -> 'a -> bool
val ( >= ) : 'a -> 'a -> bool
val compare : 'a -> 'a -> int
val min : 'a -> 'a -> 'a
val max : 'a -> 'a -> 'a

val not : bool -> bool
val ( && ) : bool -> bool -> bool
val ( || ) : bool -> bool -> bool

val ( + ) : int -> int -> int
val ( - ) : int -> int -> int
val ( * ) : int -> int -> int
val ( / ) : int -> int -> int
val ( mod ) : int -> int -> int

val abs : int -> int

val max_int : int
val min_int : int

val ( +. ) : float -> float -> float
val ( -. ) : float -> float -> float
val ( *. ) : float -> float -> float
val ( /. ) : float -> float -> float
val ( ** ) : float -> float -> float

val sqrt : float -> float
val exp : float -> float
val log : float -> float
val log10 : float -> float

val cos : float -> float
val sin : float -> float
val tan : float -> float
val acos : float -> float
val asin : float -> float
val atan : float -> float
val atan2 : float -> float -> float
val hypot : float -> float -> float
val cosh : float -> float
val sinh : float -> float
val tanh : float -> float
val acosh : float -> float
val asinh : float -> float
val atanh : float -> float

val ceil : float -> float
val floor : float -> float
val abs_float : float -> float

val float_of_int : int -> float
val int_of_float : float -> int
val int_of_char : char -> int
val char_of_int : int -> char
val string_of_bool : bool -> string
val bool_of_string : string -> bool
val bool_of_string_opt : string -> bool option
val string_of_int : int -> string
val int_of_string : string -> int
val int_of_string_opt : string -> int option

val ( ^ ) : string -> string -> string
val ( @ ) : 'a list -> 'a list -> 'a list

val fst : 'a * 'b -> 'a
val snd : 'a * 'b -> 'b

val print_string : string -> unit
val print_bytes : bytes -> unit

val read_line : unit -> string

type in_channel
type out_channel

val open_out : string -> out_channel
val flush : out_channel -> unit
val output_string : out_channel -> string -> unit
val output_bytes : out_channel -> bytes -> unit
val close_out : out_channel -> unit

val open_in : string -> in_channel
val input_line : in_channel -> string
val input_byte : in_channel -> int
val close_in : in_channel -> unit

type ('a, 'b) result = Ok of 'a | Error of 'b

module Char : sig
  val lowercase_ascii : char -> char
  val uppercase_ascii : char -> char
  val compare : char -> char -> int
  val equal : char -> char -> bool
end

module Filename : sig
  val extension : string -> string
  val remove_extension : string -> string
  val dirname : string -> string
  val basename : string -> string
end

module Float : sig
  val pi : float
  val min : float -> float -> float
  val max : float -> float -> float
  val equal : float -> float -> bool
  val compare : float -> float -> int
end

module List : sig
  val length : 'a list -> int
  val is_empty : 'a list -> bool

  val nth : 'a list -> int -> 'a
  val nth_opt : 'a list -> int -> 'a option

  val rev : 'a list -> 'a list
  val concat : 'a list list -> 'a list

  val equal : ('a -> 'a -> bool) -> 'a list -> 'a list -> bool
  val compare : ('a -> 'a -> int) -> 'a list -> 'a list -> int

  val map : ('a -> 'b) -> 'a list -> 'b list
  val filter : ('a -> bool) -> 'a list -> 'a list
  val fold_left : ('acc -> 'a -> 'acc) -> 'acc -> 'a list -> 'acc
  val fold_right : ('a -> 'acc -> 'acc) -> 'a list -> 'acc -> 'acc

  val rev_map : ('a -> 'b) -> 'a list -> 'b list
  val filter_map : ('a -> 'b option) -> 'a list -> 'b list
  val concat_map : ('a -> 'b list) -> 'a list -> 'b list
  val map2 : ('a -> 'b -> 'c) -> 'a list -> 'b list -> 'c list

  val mem : 'a -> 'a list -> bool
  val find : ('a -> bool) -> 'a list -> 'a
  val find_opt : ('a -> bool) -> 'a list -> 'a option
  val find_index : ('a -> bool) -> 'a list -> int option

  val take : int -> 'a list -> 'a list
  val drop : int -> 'a list -> 'a list
  val take_while : ('a -> bool) -> 'a list -> 'a list
  val drop_while : ('a -> bool) -> 'a list -> 'a list

  val assoc : 'a -> ('a * 'b) list -> 'b
  val assoc_opt : 'a -> ('a * 'b) list -> 'b option
  val remove_assoc : 'a -> ('a * 'b) list -> ('a * 'b) list

  val sort : ('a -> 'a -> int) -> 'a list -> 'a list
end

module Option : sig
  val value : 'a option -> default:'a -> 'a
  val default : 'a -> 'a option -> 'a

  val bind : 'a option -> ('a -> 'b option) -> 'b option
  val join : 'a option option -> 'a option
  val map : ('a -> 'b) -> 'a option -> 'b option
  val fold : none:'a -> some:('b -> 'a) -> 'b option -> 'a

  val is_none : 'a option -> bool
  val is_some : 'a option -> bool

  val equal : ('a -> 'a -> bool) -> 'a option -> 'a option -> bool
  val compare : ('a -> 'a -> int) -> 'a option -> 'a option -> int

  val to_result : none:'e -> 'a option -> ('a, 'e) result
  val to_list : 'a option -> 'a list
end

module Printf : sig
  val printf : ('a, out_channel, unit) format -> 'a
  val sprintf : ('a, unit, string) format -> 'a
end

module Random : sig
  val int : int -> int
  val float : float -> float
  val bool : unit -> bool
end

module Result : sig
  val value : ('a, 'e) result -> default:'a -> 'a
  val default : 'a -> ('a, 'e) result -> 'a

  val bind : ('a, 'e) result -> ('a -> ('b, 'e) result) -> ('b, 'e) result
  val join : (('a, 'e) result, 'e) result -> ('a, 'e) result
  val map : ('a -> 'b) -> ('a, 'e) result -> ('b, 'e) result
  val map_error : ('e -> 'f) -> ('a, 'e) result -> ('a, 'f) result
  val fold : ok:('a -> 'c) -> error:('e -> 'c) -> ('a, 'e) result -> 'c

  val is_ok : ('a, 'e) result -> bool
  val is_error : ('a, 'e) result -> bool

  val equal :
    ok:('a -> 'a -> bool) ->
    error:('e -> 'e -> bool) ->
    ('a, 'e) result -> ('a, 'e) result -> bool
  val compare :
    ok:('a -> 'a -> int) ->
    error:('e -> 'e -> int) ->
    ('a, 'e) result -> ('a, 'e) result -> int

  val to_option : ('a, 'e) result -> 'a option
  val to_list : ('a, 'e) result -> 'a list
end

module String : sig
  val init : int -> (int -> char) -> string
  val empty : string
  val length : string -> int
  val get : string -> int -> char

  val concat : string -> string list -> string

  val equal : string -> string -> bool
  val compare : string -> string -> int

  val fold_left : ('acc -> char -> 'acc) -> 'acc -> string -> 'acc
  val fold_right : (char -> 'acc -> 'acc) -> string -> 'acc -> 'acc

  val trim : string -> string
  val uppercase_ascii : string -> string
  val lowercase_ascii : string -> string
  val capitalize_ascii : string -> string
  val uncapitalize_ascii : string -> string

  val index : string -> char -> int
  val index_opt : string -> char -> int option

  val to_list : string -> char list
  val of_list : char list -> string
end

module Sys : module type of Sys
module Lexing : module type of Lexing
module Parsing : module type of Parsing
