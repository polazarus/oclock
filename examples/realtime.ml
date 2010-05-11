open Oclock

let () =
  let nsecs = gettime realtime in
  let res = getres realtime in
    Printf.printf "%Ld ns (resolution %Ld ns)\n" nsecs res;
