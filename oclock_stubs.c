/*
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
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <time.h>
#include <errno.h>

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>


CAMLprim value oclock_getres(value vclockid) {
  CAMLparam1(vclockid);
  CAMLlocal2(nsecs, res);

  clockid_t clockid = Int_val(vclockid);
  struct timespec ts;
  if (clock_getres(clockid, &ts) != 0) {
    switch (errno) {
    case EINVAL:
      /* not supported clkid*/
      caml_invalid_argument ("unsupported clock");
    case EFAULT:
      /* invalid ts, SHOULD NOT HAPPEN*/
    default:
      caml_failwith ("unknown failure");
    }
  }
  
  res = caml_alloc_tuple(2);
  
  long long ll = ts.tv_sec * 1000000000LL + ts.tv_nsec;
  
  nsecs = copy_int64(ll);
  
  CAMLreturn(nsecs);
}


CAMLprim value oclock_gettime(value vclockid) {
  CAMLparam1(vclockid);
  CAMLlocal2(nsecs, res);

  clockid_t clockid = Int_val(vclockid);
  struct timespec ts;
  if (clock_gettime(clockid, &ts) != 0) {
    switch (errno) {
    case EINVAL:
      /* not supported clkid*/
      caml_invalid_argument ("unsupported clock");
    case EFAULT:
      /* invalid ts, SHOULD NOT HAPPEN*/
    default:
      caml_failwith ("unknown failure");
    }
  }
  
  res = caml_alloc_tuple(2);
  
  long long ll = ts.tv_sec * 1000000000LL + ts.tv_nsec;
  
  nsecs = copy_int64(ll);
  
  CAMLreturn(nsecs);
}

CAMLprim value oclock_settime(value vclockid, value vvalue) {
  CAMLparam2(vclockid,vvalue);
  
  clockid_t clockid = Int_val(vclockid);
  long long ll = Int64_val(vvalue);
  struct timespec ts;
  ts.tv_sec = ll / 1000000000LL;
  ts.tv_nsec = ll % 1000000000LL; // TODO maybe add a check for negative
  
  if (clock_settime(clockid, &ts) != 0) {
    switch (errno) {
    case EINVAL:
      /* not supported clkid */
      caml_invalid_argument ("unsupported clock");
    case EPERM: /* dont have the perm */
      caml_failwith ("settime permission");
    case EFAULT:
      /* invalid ts, SHOULD NOT HAPPEN*/
    default:
      caml_failwith ("unknown failure");
    }
  }
  CAMLreturn(Val_unit);
}

CAMLprim value oclock_getcpuclockid(value vpid) {
  CAMLparam1(vpid);
  
  int pid = Int_val(vpid);
  
  clockid_t clkid;
  if (clock_getcpuclockid(pid, &clkid) != 0)  {
    switch (errno) {
    case ENOSYS:
      /* not supported clock id */
      caml_failwith ("unsupported feature");
    case EPERM: /* the user doesnt have the permission */
      caml_failwith ("invalid permission");
    case ESRCH: /* should be this one */
    case EINVAL:
    case ESPIPE: /* my linux send that one*/
      caml_invalid_argument ("invalid pid");
    default:
      caml_failwith ("unknown failure");
    }
  }
  
  CAMLreturn(Val_int(clkid));
}

CAMLprim value oclock_pthread_getcpuclockid(value vpid) {
  CAMLparam1(vpid);
  
  int pid = Int_val(vpid);
  
  clockid_t clkid;
  if (pthread_getcpuclockid(pid, &clkid) != 0)  {
    perror(NULL);
    switch (errno) {
    case ENOSYS:
      /* not supported clkid */
      caml_failwith ("unsupported feature");
    case EPERM: /* dont have the perm */
      caml_failwith ("invalid permission");
    case ESRCH:
    case EINVAL:
    case ESPIPE:
      caml_invalid_argument ("invalid pid");
    default:
      caml_failwith ("unknown failure");
    }
  }
  
  CAMLreturn(Val_int(clkid));
}
