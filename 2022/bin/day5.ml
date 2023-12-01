let data = Aoc.Common.read_lines "data/day5.txt"

let rec initalise_stacks htbl n =
  match n with
  | 0 -> ()
  | x ->
    Hashtbl.add htbl x (Stack.create ());
    initalise_stacks htbl (x - 1)
;;

let rec stack_lines acc = function
  | [] -> acc
  | h :: t ->
    if h = " 1   2   3   4   5   6   7   8   9 "
    then stack_lines acc []
    else stack_lines (h :: acc) t
;;

let rec instruction_lines = function
  | [] -> []
  | h :: t -> if h = "" then t else instruction_lines t
;;

let push_stack_items htbl key index s =
  let value = String.get s index in
  let stack = Hashtbl.find htbl key in
  if value != ' ' then Stack.push value stack else ()
;;

let rec populate_stacks htbl = function
  | [] -> ()
  | h :: t ->
    push_stack_items htbl 1 1 h;
    push_stack_items htbl 2 5 h;
    push_stack_items htbl 3 9 h;
    push_stack_items htbl 4 13 h;
    push_stack_items htbl 5 17 h;
    push_stack_items htbl 6 21 h;
    push_stack_items htbl 7 25 h;
    push_stack_items htbl 8 29 h;
    push_stack_items htbl 9 33 h;
    populate_stacks htbl t
;;

type instruction =
  { n : int
  ; fromsi : int
  ; tosi : int
  }

let parse_instruction s =
  let parts = String.split_on_char ' ' s |> Array.of_list in
  { n = Array.get parts 1 |> int_of_string
  ; fromsi = Array.get parts 3 |> int_of_string
  ; tosi = Array.get parts 5 |> int_of_string
  }
;;

let rec execute_instruction_pt1 n fromsi tosi htbl =
  match n with
  | 0 -> ()
  | _ ->
    let from_stack = Hashtbl.find htbl fromsi in
    let to_stack = Hashtbl.find htbl tosi in
    Stack.push (Stack.pop from_stack) to_stack;
    execute_instruction_pt1 (n - 1) fromsi tosi htbl
;;

(*
   1,2,3,4
   A,B,C

   3,4
*)
let rec push_list stack = function
  | [] -> ()
  | h :: t ->
    Stack.push h stack;
    push_list stack t
;;

let rec pop_list n stack lst =
  match n with
  | 0 -> lst
  | _ -> pop_list (n - 1) stack (Stack.pop stack :: lst)
;;

let execute_instruction_pt2 n fromsi tosi htbl =
  match n with
  | 0 -> ()
  | 1 ->
    let from_stack = Hashtbl.find htbl fromsi in
    let to_stack = Hashtbl.find htbl tosi in
    Stack.push (Stack.pop from_stack) to_stack;
    ()
  | _ ->
    let from_stack = Hashtbl.find htbl fromsi in
    let to_stack = Hashtbl.find htbl tosi in
    push_list to_stack (pop_list n from_stack [])
;;

let rec execute_instructions_pt1 htbl = function
  | [] -> ()
  | h :: t ->
    let inst = parse_instruction h in
    execute_instruction_pt1 inst.n inst.fromsi inst.tosi htbl;
    execute_instructions_pt1 htbl t
;;

let rec execute_instructions_pt2 htbl = function
  | [] -> ()
  | h :: t ->
    let inst = parse_instruction h in
    execute_instruction_pt2 inst.n inst.fromsi inst.tosi htbl;
    execute_instructions_pt2 htbl t
;;

let stack_tbl_pt1 = Hashtbl.create 9
let stack_tbl_pt2 = Hashtbl.create 9

let () =
  (* Part 1 *)
  initalise_stacks stack_tbl_pt1 9;
  populate_stacks stack_tbl_pt1 (stack_lines [] data);
  execute_instructions_pt1 stack_tbl_pt1 (instruction_lines data);
  (* Part 2 *)
  initalise_stacks stack_tbl_pt2 9;
  populate_stacks stack_tbl_pt2 (stack_lines [] data);
  execute_instructions_pt2 stack_tbl_pt2 (instruction_lines data)
;;

Printf.printf "part 1 - ";
Printf.printf "%c" (Hashtbl.find stack_tbl_pt1 1 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt1 2 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt1 3 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt1 4 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt1 5 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt1 6 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt1 7 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt1 8 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt1 9 |> Stack.pop);
print_endline "";
Printf.printf "part 2 - ";
Printf.printf "%c" (Hashtbl.find stack_tbl_pt2 1 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt2 2 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt2 3 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt2 4 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt2 5 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt2 6 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt2 7 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt2 8 |> Stack.pop);
Printf.printf "%c" (Hashtbl.find stack_tbl_pt2 9 |> Stack.pop);
print_endline ""
