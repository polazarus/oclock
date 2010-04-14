(*
Copyright (c) 2010, Mickaël Delahaye <mickael.delahaye@gmail.com>

Permission to use, copy, modify, and/or distribute this software for any purpose
with or without fee is hereby granted, provided that the above copyright notice
and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED “AS IS” AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF
THIS SOFTWARE.
*)

type clockid = int

(**Some clock identifiers *)
let realtime = 0
let monotonic = 1
let process_cputime = 2
let thread_cputime = 3
let monotonic_raw = 4


external getres : clockid -> Int64.t = "oclock_getres"
external gettime : clockid -> Int64.t = "oclock_gettime"
external settime : clockid -> Int64.t -> unit = "oclock_settime"

(** Get the clock identifier of a process (given its PID) *)
external getcpuclockid : int -> clockid = "oclock_getcpuclockid"

(** Get the clock identifier of a thread (given its pthread identifier) *)
external pthread_getcpuclockid : int -> clockid = "oclock_pthread_getcpuclockid"

(*let () =*)
(*  let nsecs = gettime realtime in*)
(*    Printf.printf "res: %Ld ns\n" (getres realtime);*)
(*    Printf.printf "%Ld ns\n" nsecs;*)
(*    settime realtime 0L;*)
(*    Printf.printf "%Ld ns\n" (gettime realtime);*)
    
(*let () =*)
(*  let clk = getcpuclockid 29864 in*)
(*    Printf.eprintf "ok\n%!";*)
(*    Printf.printf "%Ld ns\n" (gettime clk);*)
