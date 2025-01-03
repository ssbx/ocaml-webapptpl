
let app_name = "webapptpl"
let app_version = "1.0"


let custom_middleware next request =
  print_endline "request!";
  next request

let run listen secure =
    Dream.run ~tls:secure ~port:listen
      @@ Dream.logger
      @@ custom_middleware
      @@ Dream.router [
        Dream.get "/" (fun _ -> Dream.html "hello dream!");
        Dream.get "/echo/:word" (fun request -> 
          Dream.html (Dream.param request "word"))
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
