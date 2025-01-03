let app_name = "webapptpl"
let app_version = "1.0"

let count_success = ref 0
let count_failed = ref 0


(** asynchronous middleware example *)
let lwt_count_middleware inner request =
  try%lwt
    let%lwt response = inner request in
    count_success := !count_success + 1;
    Lwt.return response
  with exn ->
    count_failed := !count_failed + 1;
    raise exn


(** synchronous middleware example *)
let sync_print_middleware inner request =
  print_endline "request!";
  inner request


let run listen secure =
  let open Lwt in
  Dream.run 
    ~tls:secure 
    ~port:listen
    ~error_handler:Dream.debug_error_handler
    @@ Dream.logger
    @@ sync_print_middleware
    @@ lwt_count_middleware
    @@ Dream.router [
      Dream.get "/fail" (fun _ -> raise (Failure "custom failure"));
      Dream.get "/count" (fun _ -> 
        Printf.sprintf "ok:%i err:%i" !count_success !count_failed 
        |> Dream.html);
      Dream.get "/" (fun _ -> Dream.html "hello dream!");
      Dream.get "/echo/:word" (fun request -> 
        Dream.html (Dream.param request "word"));
      Dream.post "/print_request" (fun request ->
        let%lwt body = Dream.body request in
        Dream.respond
          ~headers:["Content-Type", "application/octet-stream"]
          body);
      Dream.post "/print_request2" (fun request ->
        Dream.body request 
        >>=
        Dream.respond
          ~headers:["Content-Type", "application/octet-stream"]
          );
      ]


(* 
   Command line parsing, config file parsing and initialisation 
*)
let start cfg_file =
  match Toml.Parser.from_filename cfg_file with
  | `Error (err, _) -> failwith err
  | `Ok vals ->
      let listen = 
          Toml.Types.Table.find_opt (Toml.Min.key "listen") vals
        |> function | Some Toml.Types.TInt v -> v | _ -> 8080
      and secure = 
          Toml.Types.Table.find_opt (Toml.Min.key "secure") vals
        |> function | Some Toml.Types.TBool v -> v | _ -> false in

      run listen secure 

module App = struct
  open Cmdliner

  let cfg_file =
    Arg.(
      value & opt string "./config.toml" & info ["c"; "config-file"] 
      ~docv:"CONFIG_FILE" 
      ~doc:"Config file options are read from")

  let server_t = Term.(const start $ cfg_file)

  let command =
    let doc = 
        "Start the application server. " 
      ^ "Command line options overwrite config file." in
    let man = [ `S Manpage.s_bugs
              ; `P "Email bug reports to <bugs@example.org>." ] in
    let info = 
      Cmd.info app_name
        ~version:app_version
        ~doc 
        ~man 
    in
  Cmd.v info server_t

  let main () = exit (Cmd.eval command)
end

let () = App.main ()
