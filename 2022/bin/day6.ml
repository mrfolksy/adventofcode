let data = Aoc.Common.read_lines "data/day6.txt"

(*
   In this challenge the data is one single line.
   Lets conver the string into a list of char
*)
let buffer = List.hd data |> String.to_seq |> List.of_seq
let unique_list lst = true

let rec solution acc = function
  | [] -> acc
  | h :: t ->
    let index = fst acc
    and window = snd acc in
    if List.length window = 4 && unique_list window
    then acc
    else solution (index + 1, h :: window) t
;;

let answer = solution (0, [])
