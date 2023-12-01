let data = Aoc.Common.read_lines "data/day2.txt"

(* Part 1 *)
(* First Column = what opponent will play *)
(* - A = Rock *)
(* - B = Paper *)
(* - C = Scissors *)
(* *)
(* Secons Column = what you should play *)
(* - X = Rock     (1) *)
(* - Y = Paper    (2) *)
(* - Z = Scissors (3) *)

type choice =
  | Rock
  | Paper
  | Scissors


let lose = 0
let draw = 3
let win = 6

let val_of_choice = function
  | Rock -> 1
  | Paper -> 2
  | Scissors -> 3

let round_of_string_p1 = function
  | "A X" -> (Rock, Rock)
  | "A Y" -> (Rock, Paper)
  | "A Z" -> (Rock, Scissors)
  | "B X" -> (Paper, Rock)
  | "B Y" -> (Paper, Paper)
  | "B Z" -> (Paper, Scissors)
  | "C X" -> (Scissors, Rock)
  | "C Y" -> (Scissors, Paper)
  | "C Z" -> (Scissors, Scissors)
  | _ -> failwith "Unknown Value"

(* X = lose, Y = draw, Z = Win *)
let round_of_string_p2 = function
  | "A X" -> (Rock, Scissors)
  | "A Y" -> (Rock, Rock)
  | "A Z" -> (Rock, Paper)
  | "B X" -> (Paper, Rock)
  | "B Y" -> (Paper, Paper)
  | "B Z" -> (Paper, Scissors)
  | "C X" -> (Scissors, Paper)
  | "C Y" -> (Scissors, Scissors)
  | "C Z" -> (Scissors, Rock)
  | _ -> failwith "Unknown Value"

let score_round = function
  | (Rock, Rock) -> draw + val_of_choice Rock
  | (Rock, Paper) -> win + val_of_choice Paper
  | (Rock, Scissors) -> lose + val_of_choice Scissors
  | (Paper, Rock) -> lose + val_of_choice Rock
  | (Paper, Paper) -> draw + val_of_choice Paper
  | (Paper, Scissors) -> win + val_of_choice Scissors
  | (Scissors, Rock) -> win + val_of_choice Rock
  | (Scissors, Paper) -> lose + val_of_choice Paper
  | (Scissors, Scissors) -> draw + val_of_choice Scissors

let rec calc_scores f acc = function
  | [] -> acc
  | h :: t -> calc_scores f (acc + score_round (f h)) t

(* Part 1 *)
let () = Format.sprintf "Part 1 - %d" (calc_scores round_of_string_p1 0 data) |> print_endline

(* Part 2 *)
let () = Format.sprintf "Part 2 - %d" (calc_scores round_of_string_p2 0 data) |> print_endline
