let read_lines file =
  In_channel.with_open_text file In_channel.input_all
    |> Str.(split (regexp "\n"))
;;

let rec print_list = function
  | [] -> print_endline ""
  | h :: t -> (print_endline h; print_list t)
;;

let rec print_list = function
    | [] -> print_endline "----------------------"; ()
    | h :: t -> begin
        print_endline h;
        print_list t
    end
;;

(* let rec take_aux n lst acc = *)
(*   failwith "TODO: Implement take_aux" *)

(* let take n lst = take_aux n lst [] *)
