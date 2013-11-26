open OUnit2
open Unix

let between delta x y = x < Int64.add y delta && y < Int64.add x delta;;
let pp_diff_int64 formatter (x,y) =
  Format.fprintf formatter "%Ld != %Ld" x y

let one_sec = 1_000_000_000L
let one_millisec = 1_000_000L
let one_microsec = 1_000L

let test_access _ = ignore (Oclock.gettime Oclock.realtime);;

let test_sleep_cputime _ = 
  match Oclock.process_cputime with
  | None -> skip_if true "process_cputime not available"
  | Some process_cputime ->
  let t1 = Oclock.gettime process_cputime in
  Unix.sleep 1;
  let t2 = Oclock.gettime process_cputime in
  (* The goal is not check the precision or cost of sleep just to check that the cputime does not increase much *)
  assert_equal ~cmp:(between one_millisec) ~pp_diff:pp_diff_int64 t2 t1;;

let test_sleep_realtime _ =
  let t1 = Oclock.gettime Oclock.realtime in
  Unix.sleep 1;
  let t2 = Oclock.gettime Oclock.realtime in
  (* The goal is not check the precision or cost of sleep just to check that the wall clock does increase of about 1 sec *)
  assert_equal ~cmp:(between one_millisec) ~pp_diff:pp_diff_int64 (Int64.sub t2 t1) one_sec;;


let alltests = [
	"access" >:: test_access;
	"check cputime" >:: test_sleep_cputime;
	"check realtime" >:: test_sleep_realtime
]

let () = run_test_tt_main ("all tests" >::: alltests)

