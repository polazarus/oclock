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

type clockid = int

external getclocks : unit -> int * int * int * int * int * int * int option * int option = "oclock_getclocks"

let (realtime, realtime_coarse,
    monotonic, monotonic_coarse, monotonic_raw, boottime,
    process_cputime, thread_cputime) =
  getclocks ()

external getres : clockid -> Int64.t = "oclock_getres"
external gettime : clockid -> Int64.t = "oclock_gettime"
external settime : clockid -> Int64.t -> unit = "oclock_settime"

external getcpuclockid : int -> clockid = "oclock_getcpuclockid"

external pthread_getcpuclockid : int -> clockid = "oclock_pthread_getcpuclockid"
