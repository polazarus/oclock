(*
Copyright (c) 2011-2013, Mickaël Delahaye, http://micdel.fr

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
  Oclock: precise POSIX clock for OCaml
  
  This module gives access to the [clock_gettime (2)] family of functions to
  Ocaml programs.
  
  If this module allows programs to get time at real- or CPU-time clocks in
  nanoseconds, the actual precision of the clocks might be much coarser.
  Also, the resolution of a clock, {!getres} should indicate the period of the
  timer used for this clock, but the actual precision of the clock greatly
  depends on the CPU (watch out for frequency scaling!) and its time source.
  You can estimate the precision available on your platform with the shipped
  example [examples/realtime].
*)

(** Clock identifier type *)
type clockid = int

(** {2 Clock access } *)

(** Gets the clock's resolution in nanoseconds.*)
external getres : clockid -> int64 = "oclock_getres"

(** Gets the clock's time in nanoseconds. *)
external gettime : clockid -> int64 = "oclock_gettime"

(** Sets the clock's time in nanoseconds. *)
external settime : clockid -> int64 -> unit = "oclock_settime"

(** The three above functions raise [Invalid_argument] if the clock identifier
 is not supported, and a [Failure] if the call fails for any other reason
 (including permission problems). *)

(** {2 Clock identifiers } *)

(** {3 Standard clock identifiers } *)

(** Realtime (always valid) *)
val realtime : clockid

(** Faster but less precise realtime clock, through
  Linux-specific extension [CLOCK_REALTIME_COARSE] (since 2.6.32)
  or FreeBSD equivalent [CLOCK_REALTIME_FAST].
  If not available, set to {!realtime}. *)
val realtime_coarse : clockid

(** Monotonic clock (not subject to system time change) *)
val monotonic : clockid

(** Faster but less precise monotonic clock, through
  Linux-specific extension [CLOCK_MONOTONIC_COARSE] (since 2.6.32)
  or FreeBSD equivalent [CLOCK_MONOTONIC_FAST].
  If not available, set to {!monotonic}. *)
val monotonic_coarse : clockid

(** Linux-specific monotonic clock (since 2.6.28), not subject to
  NTP adjustements. If not available, set to {!monotonic}. *)
val monotonic_raw : clockid

(** Linux-specific monotonic clock that includes any time the system is
  suspended (since 2.6.39). If not available, set to {!monotonic}. *)
val boottime : clockid

(** Current process CPU-time clock (Linux since 2.6.12 and OpenBSD) *)
val process_cputime : clockid option

(** Current thread CPU-time clock (Linux since 2.6.12 and OpenBSD) *)
val thread_cputime : clockid option


(** {3 Remote clock identifiers } *)

(** Gets the CPU-time clock identifier of a process (given its PID).

  Raises an [Invalid_argument] exception if the provided integer is not a valid
  PID, and a [Failure] if the calls fails for any other reason (including
  permission problems).
*)
external getcpuclockid : int -> clockid = "oclock_getcpuclockid"

(** Gets the CPU-time clock identifier of a thread given its pthread identifier,
  as returned by [Thread.id] (but only if you use real POSIX threads [-thread]
  and not VM threads [-vmthread]).
  
  Raises an [Invalid_argument] exception if the provided integer is not a valid
  thread identifier, and a [Failure] if the calls fails for any other reason
  (including permission problems).
*)
external pthread_getcpuclockid : int -> clockid = "oclock_pthread_getcpuclockid"
