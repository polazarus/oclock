(** Example of realtime measurement with Oclock *)

(** Experimentally estimates the precision of a clock by observing gaps between
  [num] successive measures (by default 100000).
  Returns the observed (arithmetic) mean, the standard deviation, the minimal
  value and the maximal value.
*)
let measure_precision ?(num=100000) clkid =
  let t () = Oclock.gettime clkid in
  let measures = Array.make num 0L in
  for i = 0 to num - 1 do
    measures.(i) <- t ();
  done;
  let last = ref measures.(0) in
  let nb_diffs = ref 0 in
  let diffs = ref [] in
  for i = 1 to num - 1 do
    if measures.(i) <> !last then begin
      incr nb_diffs;
      diffs := Int64.to_float (Int64.sub measures.(i) !last) :: !diffs;
      last := measures.(i);
    end
  done;
  let n = float_of_int !nb_diffs in
  let mean = (List.fold_left (+.) 0.0 !diffs) /. n  in
  let var =  (List.fold_left (fun acc e -> (e -. mean) ** 2.0 +. acc) 0.0 !diffs) /. n in
  let min = List.fold_left min max_float !diffs in
  let max = List.fold_left max min_float !diffs in
  let stddev = var ** 0.5 in
    mean, stddev, min, max

(** Gets time since Epoch and evaluates the precision of the clock *)
let () =
  let nsecs = Oclock.gettime Oclock.realtime in
  let res = Oclock.getres Oclock.realtime in
    Printf.printf "%Ld ns since the Epock (resolution %Ld ns)\n" nsecs res;

  let prec, precsv, max, min = measure_precision Oclock.realtime in
    Printf.printf "Precision evaluation\n  Mean: %10.2f ns\n  Sdev: %10.2f ns\n  Min:  %10.2f ns\n  Max:  %10.2f ns\n" prec precsv min max
