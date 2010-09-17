(** Example of CPU-time measurement with Oclock *)

let rec loop () =
  Printf.printf "PID? ";
  try
    let pid = read_int () in
    begin try
      let clk = Oclock.getcpuclockid pid in
      let time = Oclock.gettime clk in
      Printf.printf "The process %d used %Ld ns of CPU time up until now.\n\n" pid time;
    with Invalid_argument s | Failure s ->
      Printf.printf "Error: %s\n" s;
    end;
    loop ();
  with End_of_file ->
    Printf.printf "Bye!\n"
  
let () =
  loop ()
