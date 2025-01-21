let get_count _ =
  Dream.info (fun log -> log "hello get_coung");
  Printf.sprintf "ok:%i err:%i" 
    !Middlewares.Lwt_count.count_success 
    !Middlewares.Lwt_count.count_failed 
  |> Dream.html

let fail_fun _ =
  Dream.error (fun log -> log "proooobolllem");
  raise (Failure "custom failure")
