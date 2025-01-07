(** synchronous middleware example *)
let apply inner request =
  print_endline "request!";
  inner request

