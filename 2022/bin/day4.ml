open BatList

let data = Aoc.Common.read_lines "data/day4.txt"

let parse_field s =
  let lst = String.split_on_char '-' s in
  List.nth lst 0 |> int_of_string, List.nth lst 1 |> int_of_string
;;

let parse_record s =
  let pair = String.split_on_char ',' s in
  parse_field (List.nth pair 0), parse_field (List.nth pair 1)
;;

module ISet = Set.Make (Int)

let list_of_sections elf = BatList.range (fst elf) `To (snd elf) |> ISet.of_list

let fully e1 e2 =
  (fst e1 <= fst e2 && snd e1 >= snd e2) || (fst e2 <= fst e1 && snd e2 >= snd e1)
;;

let partially e1 e2 =
  ISet.inter (list_of_sections e1) (list_of_sections e2) |> ISet.is_empty |> not
;;

let contains f e1 e2 = if f e1 e2 then 1 else 0

let rec solution acc = function
  | [] -> acc
  | h :: t ->
    let elfs = parse_record h in
    let elf1 = fst elfs in
    let elf2 = snd elfs in
    solution
      (fst acc + contains fully elf1 elf2, snd acc + contains partially elf1 elf2)
      t
;;

let x = solution (0, 0) data
let () = Printf.printf "Part 1 - %d\n" (fst x)
let () = Printf.printf "Part 2 - %d\n" (snd x)
