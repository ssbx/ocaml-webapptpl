let count_success = ref 0
let count_failed = ref 0


(** asynchronous middleware example *)
let apply inner request =
  try%lwt
    let%lwt response = inner request in
    count_success := !count_success + 1;
    Lwt.return response
  with exn ->
    count_failed := !count_failed + 1;
    raise exn

