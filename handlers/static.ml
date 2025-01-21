open Lwt

let handle request =
  Dream.static "./public" request 
    >|= (fun response -> 
      Dream.add_header response "Cache-Control" "max-age=604800";
      response)
