let app_name = "webapptpl"
let app_version = "1.0"
open App

let error_template _error debug_info suggested_response =
  let status = Dream.status suggested_response in
  let code = Dream.status_to_int status
  and reason = Dream.status_to_string status in

  Dream.set_header suggested_response "Content-Type" Dream.text_html;
  Dream.set_body suggested_response (Templates.Error.render code reason debug_info);
  Lwt.return suggested_response

let run listen secure =
  let proto = if secure then "https" else "http" in
  Dream.info (fun log -> log "Listening on %s://localhost:%i." proto listen);
  Dream.run 
    ~tls:secure 
    ~port:listen
    ~error_handler:(Dream.error_template error_template)
    ~greeting:false
    ~adjust_terminal:false
    @@ Dream.logger
    @@ Middlewares.Sync_print.apply
    @@ Middlewares.Lwt_count.apply
    @@ Dream.router Config.Routes.lst

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
      value & opt string "./webapptpl.toml" & info ["c"; "config-file"] 
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

