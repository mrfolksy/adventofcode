let data = Aoc.Common.read_lines "data/day3.txt"


(*  *)
(* RCMRQjLLWGTj nlnZwwnZJRZH *)
(*  *)
module CSet = Set.Make(Char)

(* a=1 *)
(* A=27 *)
let value_from_char char =
  if Char.code char < 91
  then
    (Char.code char) - 38
  else
    Char.code char - 96

let str_to_charset s =
  s |> String.to_seq |> List.of_seq |> CSet.of_list
;;

let duplicate_item rucksack =
 let m = (rucksack |> String.length) / 2 in
  let r1 = (String.sub rucksack 0 m) |> str_to_charset
    and r2 = (String.sub rucksack m m) |> str_to_charset in
      CSet.inter r1 r2 |> CSet.to_seq |> List.of_seq |> List.hd
;;

let rec calculate_part1 acc = function
  | [] -> acc
  | h :: t -> begin
      calculate_part1 (acc + (h |> duplicate_item |> value_from_char)) t
    end
;;


let rec find_badges_aux cset = function
  | [] -> cset |> CSet.to_seq |> List.of_seq |> List.hd
  | h :: t -> begin
      if CSet.is_empty cset then
      find_badges_aux (h |> str_to_charset) t
      else find_badges_aux (CSet.inter (h |> str_to_charset) cset) t
    end
;;

let find_badges rucksacks = find_badges_aux CSet.empty rucksacks
;;

let rec calculate_part2 acc = function
  | [] -> begin
      match acc with (rucksacks, total) ->
          total + (find_badges rucksacks |> value_from_char)
    end
  | h :: t -> begin
     match acc with (rucksacks, total) ->
       if List.length rucksacks = 3 then
         let x = find_badges rucksacks in
            calculate_part2 ([h], total + (x |> value_from_char)) t
       else
         calculate_part2 (h :: rucksacks, total) t
    end
;;

(* part1 *)
let () = Printf.printf "%d\n" (calculate_part1 0 data)

(* part2 *)
let () = Printf.printf "%d\n" (calculate_part2 ([], 0) data)
