
open Lwt

let handle_async request = 
  let%lwt body = Dream.body request in
  Dream.respond
    ~headers:["Content-Type", "application/octet-stream"]
    body


let handle_sync request =
  Dream.body request >>=
  Dream.respond
    ~headers:["Content-Type", "application/octet-stream"]
