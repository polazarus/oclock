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

(**
  OClock: precise time under POSIX
  
  A module to get more precise time under POSIX systems using clock_gettime(2).
*)

(** Clock identifier type *)
type clockid = int

(**Some clock identifiers *)

(** Realtime (always valid) *)
val realtime : clockid

(** Monotonic (not subject to system time change) *)
val monotonic : clockid

(** Process CPU time *)
val process_cputime : clockid

(** Thread CPU time *)
val thread_cputime : clockid

(** Another monotonic clock (not always present, since Linux 2.6.28; Linux-specific), not subject to NTP adjustements *)
val monotonic_raw : clockid

(** Get the clock's resolution in nanoseconds*)
external getres : clockid -> Int64.t = "oclock_getres"

(** Get the clock's time in nanoseconds *)
external gettime : clockid -> Int64.t = "oclock_gettime"

(** Set the clock's time in nanoseconds *)
external settime : clockid -> Int64.t -> unit = "oclock_settime"

(** Get the clock identifier of a process (given its PID) *)
external getcpuclockid : int -> clockid = "oclock_getcpuclockid"

(** Get the clock identifier of a thread (given its pthread identifier) *)
external pthread_getcpuclockid : int -> clockid = "oclock_pthread_getcpuclockid"
