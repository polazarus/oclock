open OUnit2
open Oclock

let test_access _ = ignore (Oclock.gettime Oclock.realtime);;
let test_goodres _ = ignore (Oclock.gettime Oclock.realtime);;
let test_sleep_user _ = ignore (Oclock.gettime Oclock.realtime);;
let test_sleep_wallclock _ = ignore (Oclock.gettime Oclock.realtime);;

let alltests = [
	"access" >:: test_access;
	"good res" >:: test_goodres;
	"sleep user" >:: test_sleep_user;
	"sleep wallclock" >:: test_sleep_wallclock
]

let () = run_test_tt_main ("all tests" >::: alltests)

