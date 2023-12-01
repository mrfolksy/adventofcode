let data = Aoc.Common.read_lines "./data/day1.txt"

let rec group_and_sum_aux acc result = function
  | [] -> result
  | h :: t -> begin
      if h = "" then
        group_and_sum_aux 0 (acc :: result) t
      else
        group_and_sum_aux (acc + (int_of_string h)) result t
  end
;;

let group_and_sum input = group_and_sum_aux 0 [] input

let cals = group_and_sum data |> List.sort (fun x y -> ~- (compare x y))

(* part 1 *)
let () = Printf.printf "%d\n" (List.hd cals)

(* part 2 *)
(* use list and match to get top 3*)
let top3 = match cals with
  | a :: b :: c :: _ -> [a; b; c]
  | _ -> failwith "Something went wrong!"

let () = Printf.printf "%d\n" (List.fold_left ( + ) 0 top3)

(* convert to Seq and 'take' 3 *)
let top3_seq = cals |> List.to_seq |> Seq.take 3

let () = Printf.printf "%d\n" (Seq.fold_left ( + ) 0 top3_seq)
